import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezdaassesment/features/core/assets/AssetsManager.dart';
import 'package:tezdaassesment/features/core/navigation/routes.dart';
import 'package:tezdaassesment/features/core/theme/hegmof_theme.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/BackButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HFilledButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/layouts/ScollableColumn.dart';
import 'package:tezdaassesment/features/core/theme/widgets/sheets/GenericBottomSheet.dart';
import 'package:tezdaassesment/features/core/theme/widgets/sheets/bottom_sheets.dart';
import 'package:tezdaassesment/features/core/theme/widgets/textfields/HTextFields.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/riverpod/register/registration_provider.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return RegistrationScreenState();
  }
}

class RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  bool obscurePassword = false;
  bool obscureConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final currentState = ref.watch(registerProvider);
    final registerProviderNotifier = ref.read(registerProvider.notifier);

    ref.listen(registerProvider, (prev, next) async {
      final currentState = next;
      if (currentState.networkError == true) {
        showYouAreOfflineSheet(context);
      }
      if (currentState.timeOutError == true) {
        showPoorNetworkSheet(context, () async {
          registerProviderNotifier.register();
        });
      }
      if (currentState.serverError != null) {
        context.showError(currentState.serverError!);
      }
      if (currentState.submitted == true) {
        await context.showBottomSheet<bool>(GenericBottomSheet(
            title: context.getLocalization()!.account_created_successfully,
            icon: AllAppAssets.SuccessCheckSvg.getPath(),
            body: "Welcome to my assessment, hope you like what you see",
            actionText: context.getLocalization()!.continuee,
            onAction: () {
              context.popToScreen(AppRoutes.HomeScreen);
            }));
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: backButton(context),
      ),
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: false,
      body: Padding(
        padding: horizontalPadding.copyWith(
            bottom: context.getBottomPadding(), top: 10.h),
        child: HScollableColumn(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              context.getLocalization()!.register_for_this_assesment,
              style: context.getTextTheme().titleLarge,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              context.getLocalization()!.enter_your_personal_details_below,
              style: context.getTextTheme().bodyMedium,
            ),
            SizedBox(
              height: 20.h,
            ),
            HTextField(
              title: context.getLocalization()!.full_name,
              value: currentState.name,
              error: currentState.nameError,
              onChange: (value) {
                registerProviderNotifier.handleUpdateValue(
                    SignUpFieldTypes.NAME, value);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            HTextField(
              title: context.getLocalization()!.email,
              value: currentState.emailAddress,
              error: currentState.emailError,
              onChange: (value) {
                registerProviderNotifier.handleUpdateValue(
                    SignUpFieldTypes.EMAIL, value);
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            HTextField(
              obscureText: obscurePassword,
              value: currentState.password,
              error: currentState.passwordError,
              onChange: (value) {
                registerProviderNotifier.handleUpdateValue(
                    SignUpFieldTypes.PASSWORD, value);
              },
              title: context.getLocalization()!.create_password,
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  child: Icon(
                    obscurePassword
                        ? Icons.lock_clock
                        : Icons.remove_red_eye_rounded,
                    size: 15.w,
                  )),
              controller: TextEditingController(),
            ),
            SizedBox(
              height: 20.h,
            ),
            HTextField(
              title: context.getLocalization()!.confirm_password,
              obscureText: obscureConfirmPassword,
              value: currentState.confirmpassword,
              error: currentState.confirmpasswordError,
              onChange: (value) {
                registerProviderNotifier.handleUpdateValue(
                    SignUpFieldTypes.CONFIRM_PASSWORD, value);
              },
              suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  child: Icon(
                    obscureConfirmPassword
                        ? Icons.lock_clock
                        : Icons.remove_red_eye,
                    size: 15.w,
                  )),
            ),
            SizedBox(
              height: 20.h,
            ),
            HFilledButton(
              text: context.getLocalization()!.continuee,
              enabled: currentState.isValid(),
              loading: currentState.submitting,
              onPressed: () {
                registerProviderNotifier.register();
              },
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
