import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezdaassesment/features/core/navigation/routes.dart';
import 'package:tezdaassesment/features/core/theme//app_theme.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/BackButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HFilledButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/layouts/ScollableColumn.dart';
import 'package:tezdaassesment/features/core/theme/widgets/sheets/bottom_sheets.dart';
import 'package:tezdaassesment/features/core/theme/widgets/textfields/HTextFields.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/riverpod/auth_state.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/riverpod/login_provider.dart';

class Loginscreen extends ConsumerStatefulWidget {
  const Loginscreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginscreenState();
  }
}

class _LoginscreenState extends ConsumerState<Loginscreen> {
  bool obscurePassword = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    // Listen to changes and react (equivalent to BlocListener)
    ref.listen<AuthStateForm>(loginProvider, (previous, next) {
      if (next.isSuccess) {
        context.showSuccess("Logged in");
        context.goToScreen(AppRoutes.HomeScreen);
      }
      if (next.serverError != null) {
        context.showError(next.serverError!);
      }
      if (next.timeOutError == true) {
        showPoorNetworkSheet(context, () async {
          ref.read(loginProvider.notifier).login();
        });
      }
      if (next.networkError == true) {
        showYouAreOfflineSheet(context);
      }
    });
    return Scaffold(
        appBar: AppBar(
          leading: backButton(context),
        ),
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        body: SafeArea(
            child: Padding(
                padding: horizontalPadding.copyWith(
                    bottom: context.getBottomPadding(), top: 10.h),
                child: HScollableColumn(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      SizedBox(
                        width: context.getWidth(),
                        child: Text(
                          context.getLocalization()!.welcome_back,
                          textAlign: TextAlign.center,
                          style: context.getTextTheme().titleLarge,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: context.getWidth(),
                        child: Text(
                          context.getLocalization()!.log_in_to_your_account,
                          textAlign: TextAlign.center,
                          style: context.getTextTheme().bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      HTextField(
                        title: context.getLocalization()!.email,
                        value: state.email,
                        error: state.emailError,
                        onChange: (value) {
                          ref
                              .read(loginProvider.notifier)
                              .updateValue(value, LoginField.EMAIL);
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      HTextField(
                        title: context.getLocalization()!.password,
                        obscureText: obscurePassword,
                        value: state.password,
                        onChange: (value) {
                          ref
                              .read(loginProvider.notifier)
                              .updateValue(value, LoginField.PASSWORD);
                        },
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.close_fullscreen
                                  : Icons.remove_red_eye,
                              size: 15.w,
                            )),
                        controller: TextEditingController(),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      HFilledButton(
                        text: context.getLocalization()!.continuee,
                        enabled: state.isValidForLogin(),
                        onPressed: () {
                          ref.read(loginProvider.notifier).login();
                        },
                        loading: state.isSubmitting,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Text(
                            context.getLocalization()!.dont_have_an_account,
                            style: context.getTextTheme().bodySmall,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              context.goToScreen(AppRoutes.Register);
                            },
                            child: Text(
                                context.getLocalization()!.create_account,
                                style: context
                                    .getTextTheme()
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color:
                                            context.getColorScheme().primary)),
                          ),
                        ],
                      ),
                    ]))));
  }
}
