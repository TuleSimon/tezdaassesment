import 'package:equatable/equatable.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';

final class ProfileState extends Equatable {
  final bool edittingProfile;
  final bool submittinEdit;
  final String? editError;
  final bool editSuccess;
  final String? name;
  final String? nameError;
  final LoggedInUser? profile;
  final String? emailAddress;
  final String? emailAddressError;
  final String? imagePath;
  final bool? networkError;
  final bool? poorNetworkError;

  @override
  List<Object?> get props => [
        edittingProfile,
        submittinEdit,
        editError,
        profile,
        editSuccess,
        emailAddress,
        emailAddressError,
        imagePath,
        networkError,
        poorNetworkError,
      ];

  const ProfileState({
    required this.edittingProfile,
    required this.submittinEdit,
    this.editError,
    this.editSuccess = false,
    this.profile,
    this.name,
    this.nameError,
    this.emailAddress,
    this.emailAddressError,
    this.imagePath,
    this.networkError,
    this.poorNetworkError,
  });

  ProfileState copyWith(
      {bool? edittingProfile,
      bool? submittinEdit,
      LoggedInUser? profile,
      String? editError,
      bool? editSuccess,
      String? name,
      String? nameError,
      String? emailAddress,
      String? emailAddressError,
      String? imagePath,
      bool? networkError,
      bool? poorNetworkError}) {
    return ProfileState(
      edittingProfile: edittingProfile ?? this.edittingProfile,
      submittinEdit: submittinEdit ?? this.submittinEdit,
      editError: editError,
      editSuccess: editSuccess ?? false,
      profile: profile ?? this.profile,
      emailAddress: emailAddress ?? this.emailAddress,
      name: name ?? this.name,
      nameError: nameError ?? this.nameError,
      emailAddressError: emailAddressError,
      imagePath: imagePath ?? this.imagePath,
      networkError: networkError,
      poorNetworkError: poorNetworkError,
    );
  }

  ProfileState copyWith2({
    bool? edittingProfile,
    bool? submittinEdit,
    LoggedInUser? profile,
    String? editError,
    bool? editSuccess,
    String? name,
    String? nameError,
    String? emailAddress,
    String? emailAddressError,
    String? imagePath,
    bool? networkError,
    bool? poorNetworkError,
  }) {
    return ProfileState(
      edittingProfile: edittingProfile ?? this.edittingProfile,
      submittinEdit: submittinEdit ?? this.submittinEdit,
      editError: editError,
      editSuccess: editSuccess ?? false,
      profile: profile ?? this.profile,
      emailAddress: emailAddress,
      name: name,
      nameError: nameError ?? this.nameError,
      emailAddressError: emailAddressError,
      imagePath: imagePath ?? this.imagePath,
      networkError: networkError,
      poorNetworkError: poorNetworkError,
    );
  }

  bool isValid() {
    return nameError == null &&
        emailAddressError == null &&
        (name != null || emailAddress != null);
  }
}
