import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezdaassesment/features/core/assets/AssetsManager.dart';
import 'package:tezdaassesment/features/core/navigation/routes.dart';
import 'package:tezdaassesment/features/core/theme/app_colors.dart';
import 'package:tezdaassesment/features/core/theme/hegmof_theme.dart';
import 'package:tezdaassesment/features/core/theme/utils.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HFilledButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HOutlinedButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/cards/GradientCard.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class Onboardinghomescreen extends StatelessWidget {
  const Onboardinghomescreen({super.key}) : super();

  Future<void> changeBars(BuildContext context) async {
    changeNavigationBarColorCustomizable("onboarding home", context,
        iconBrightness: Brightness.light,
        navigationBarColor: AppColors.primaryBlue);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: changeBars(context),
        builder: (context, p) {
          return Scaffold(
            backgroundColor: AppColors.primaryBlue,
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Image.asset(
                    AllAppAssets.OnboardingHomeImage.getPath(),
                    fit: BoxFit.cover,
                    width: context.getWidth(),
                    height: context.getSize().height,
                  ),
                ),
                Positioned(
                  bottom: context.getBottomPadding() + 10.h,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: horizontalPadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                              child: GradientCard(
                                  children: Text("Welcome",
                                      style: context
                                          .getAppTheme()
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                              color:
                                                  AppColors.textHeaderColor)))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Welcome to My Assesment",
                            textAlign: TextAlign.center,
                            style: context
                                .getAppTheme()
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: context
                                      .getAppTheme()
                                      .colorScheme
                                      .onPrimary,
                                  fontWeight: FontWeight.w800,
                                  height: 0.9.h,
                                  fontSize: 40.sp,
                                ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "A small assessment showcasing a product and product details app",
                            style: context
                                .getAppTheme()
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: context
                                        .getAppTheme()
                                        .colorScheme
                                        .onPrimary,
                                    fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          HFilledButton(
                            text: context.getLocalization()!.register,
                            onPressed: () =>
                                context.goToScreen(AppRoutes.Register),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Houtlinedbutton(
                              text: context.getLocalization()!.login,
                              onPressed: () =>
                                  context.goToScreen(AppRoutes.LoginScreen))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
