import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tezdaassesment/features/core/assets/AssetsManager.dart';
import 'package:tezdaassesment/features/core/theme/app_colors.dart';
import 'package:tezdaassesment/features/core/theme//app_theme.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HFilledButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/cards/GradientCard.dart';
import 'package:tezdaassesment/features/core/theme/widgets/dialog/HAlertDialog.dart';
import 'package:tezdaassesment/features/core/theme/widgets/image/HNetworkImage.dart';
import 'package:tezdaassesment/features/core/theme/widgets/layouts/ScollableColumn.dart';
import 'package:tezdaassesment/features/core/theme/widgets/sheets/bottom_sheets.dart';
import 'package:tezdaassesment/features/core/theme/widgets/text/TextWithIcon.dart';
import 'package:tezdaassesment/features/core/theme/widgets/textfields/HTextFields.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/riverpod/register/registration_provider.dart';
import 'package:tezdaassesment/features/modules/profile/presentation/provider/profile_provider.dart';

class ProfileHomeScreen extends ConsumerWidget {
  const ProfileHomeScreen({super.key}) : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.read(profileProvider.notifier);
    final currentState = ref.watch(profileProvider);
    ref.listen(profileProvider, (prev, next) {
      if (prev == null) {
        profileNotifier.refreshProfile();
      }
      if (next.editSuccess) {
        context.showSuccess("Profile Updated");
      }

      if (next.editError != null) {
        context.showError(next.editError!);
      }
      if (next.poorNetworkError == true) {
        showPoorNetworkSheet(context, () async {});
      }
      if (next.networkError == true) {
        showYouAreOfflineSheet(context);
      }
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.successColor.withOpacity(0.1),
          centerTitle: true,
          automaticallyImplyLeading: false,
          titleTextStyle: context.getTextTheme().titleSmall,
          leadingWidth: 55.w,
          leading: Padding(
            padding: EdgeInsets.only(left: horizontalPadding.left),
            child: InkWell(
              onTap: () => context.pop(),
              child: GradientCard(
                color: context.getColorScheme().onPrimary,
                insets: const EdgeInsets.all(0),
                shape: BoxShape.circle,
                children: Icon(
                  Icons.chevron_left,
                  size: 25.w,
                ),
              ),
            ),
          ),
          title: Text(
            context.getLocalization()!.profile,
            style: context.getTextTheme().bodySmall,
          ),
        ),
        bottomNavigationBar: HFilledButton(
            bgColor: context.getColorScheme().surface,
            onPressed: () {
              context.showCustomDialog(HAlertDialog(
                  title: context.getLocalization()!.logout,
                  description: context
                      .getLocalization()!
                      .are_you_sure_you_want_to_logout,
                  buttonText: context.getLocalization()!.logout,
                  onButtonClikced: () {
                    context.pop();
                    profileNotifier.logout();
                  },
                  onCancelClikced: () {
                    context.pop();
                  }));
            },
            textColor: context.getColorScheme().onSurface,
            text: context.getLocalization()!.logout),
        body: HScollableColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FractionallySizedBox(
                  widthFactor: 1,
                  child: ColoredBox(
                      color: AppColors.successColor.withOpacity(0.1),
                      child: Padding(
                        padding: horizontalPadding,
                        child: Column(children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Stack(children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(context.getWidth()),
                              child: Hnetworkimage(
                                image: currentState.profile?.avatar ?? "",
                                fit: BoxFit.cover,
                                height: context.getSize().height * 0.14,
                                width: context.getSize().height * 0.14,
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 0,
                              child: InkWell(
                                onTap: () => profileNotifier.uploadPic(),
                                child: GradientCard(
                                  insets: EdgeInsets.all(5.w),
                                  children: SvgPicture.asset(
                                    AllAppAssets.EditPenSvg.getPath(),
                                    width: 14.w,
                                    height: 14.h,
                                  ),
                                ),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            currentState.profile?.name ?? "",
                            style: context.getTextTheme().titleLarge,
                          ),
                          HTextWithIcon(
                            alignment: MainAxisAlignment.center,
                            text: currentState.profile?.email ?? "",
                            assets2: AllAppAssets.verifiedIcon.getPath(),
                            style: context.getTextTheme().bodyMedium,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            currentState?.profile?.role ?? "",
                            style: context.getTextTheme().bodySmall,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ]),
                      ))),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: horizontalPadding,
                child: HTextField(
                  onChange: (value) {
                    profileNotifier.handleUpdateValue(
                        SignUpFieldTypes.NAME, value);
                  },
                  title: context.getLocalization()!.full_name,
                  value: currentState.name ?? currentState.profile?.name,
                  error: currentState.nameError,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: horizontalPadding,
                child: HTextField(
                  onChange: (value) {
                    profileNotifier.handleUpdateValue(
                        SignUpFieldTypes.EMAIL, value);
                  },
                  title: context.getLocalization()!.email,
                  value:
                      currentState.emailAddress ?? currentState.profile?.email,
                  error: currentState.emailAddressError,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: horizontalPadding,
                child: HFilledButton(
                    enabled: currentState.edittingProfile == true &&
                        currentState.isValid(),
                    loading: currentState.submittinEdit,
                    onPressed: () {
                      profileNotifier.updateProfile();
                    },
                    text: context.getLocalization()!.save_changes),
              )
            ]));
  }
}
