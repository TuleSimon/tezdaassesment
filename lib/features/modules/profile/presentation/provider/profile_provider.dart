import 'dart:async';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezdaassesment/features/core/navigation/go_router.dart';
import 'package:tezdaassesment/features/core/theme/widgets/sheets/GenericBottomSheet.dart';
import 'package:tezdaassesment/features/core/utils/error/exceptions.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/authentication/data/datasources/params/UpdateProfileParams.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/usecases/refresh_profile_usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/domain/usecases/update_profile_usecase.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/riverpod/register/registration_provider.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/utils/signup_validator.dart';
import 'package:tezdaassesment/features/modules/common/no_params.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';
import 'package:tezdaassesment/features/modules/products/domain/usecase/get_products_usecase.dart';
import 'package:tezdaassesment/features/modules/profile/presentation/provider/states/profile_state.dart';

@Riverpod(keepAlive: true)
class ProfileNotifier extends Notifier<ProfileState> {
  final GetProductsUsecase getProductsUsecase =
      GetIt.instance<GetProductsUsecase>();
  final PreferenceManager preferenceManager =
      GetIt.instance<PreferenceManager>();
  final RefreshProfileUsecase refreshProfileUsecase =
      GetIt.instance<RefreshProfileUsecase>();
  final UpdateProfileUsecase updateProfileUsecase =
      GetIt.instance<UpdateProfileUsecase>();
  final Signupvalidator validator = GetIt.instance<Signupvalidator>();

  @override
  ProfileState build() {
    preferenceManager.getUserData2().then((user) {
      state = state.copyWith(profile: user);
    });
    preferenceManager.getLoggedInUserStream().listen((user) {
      state = state.copyWith(profile: user);
    });
    refreshProfile();
    return const ProfileState(edittingProfile: false, submittinEdit: false);
  }

  void refreshProfile() {
    refreshProfileUsecase(params: const NoParams());
  }

  void updateProfile() async {
    final res = await updateProfileUsecase(
        params: Updateprofileparams(
            name: state.name,
            email: state.emailAddress,
            avatar: state.imagePath));
    res.fold((err) {
      if (err is TimeoutException) {
        state = state.copyWith(poorNetworkError: true);
      }
      if (err is NetworkException) {
        state = state.copyWith(networkError: true);
      }
      if (err is ServerException) {
        state = state.copyWith(editError: err.message);
      }
    }, (result) {
      state = state.copyWith(editSuccess: true);
    });
  }

  Future<void> handleUpdateValue(SignUpFieldTypes field, String value) async {
    state = (state.copyWith(edittingProfile: true));
    switch (field) {
      case SignUpFieldTypes.EMAIL:
        {
          state = state.copyWith2(
              emailAddress: value != state.profile?.email ? value : null,
              name: state.name);
        }
      case SignUpFieldTypes.NAME:
        {
          state = state.copyWith2(
              name: value != state.profile?.name ? value : null,
              emailAddress: state.emailAddress);
        }

      default:
        {}
    }
    await _validateFields();
  }

  Future<void> _validateFields() async {
    final currentState = state;
    final isNameValid = currentState.name == null
        ? null
        : validator.validateName(currentState.name!);
    final isEmailValid = currentState.emailAddress == null
        ? null
        : validator.validateUserEmail(currentState.emailAddress!);
    state = state.copyWith(
        nameError: isNameValid?.message,
        emailAddressError: isEmailValid?.message);
  }

  void logout() {
    preferenceManager.clearUserData();
  }

  uploadPic() async {
    final context = parentKey.currentContext;

    if (context != null) {
      final result = await context
          .showBottomSheet<File?>(selectImageSourceSheet(context, (file) {}));
      if (result != null) {
        state = state.copyWith(imagePath: result.path);
        updateProfile();
      }
    }
  }
}

final profileProvider =
    NotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);
