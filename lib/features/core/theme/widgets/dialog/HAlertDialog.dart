import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HFilledButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HOutlinedButton.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class HAlertDialog extends StatelessWidget {
  final String title;
  final String description;

  final String buttonText;
  final String? icon;
  final String? iconpng;
  final bool hideNegative;
  final Function() onButtonClikced;
  final Function() onCancelClikced;

  const HAlertDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.onButtonClikced,
      this.icon,
      this.hideNegative = false,
      this.iconpng,
      required this.onCancelClikced});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.getAppTheme().cardColor,
        borderRadius: BorderRadius.circular(10.w),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Container(
          decoration: BoxDecoration(
            color: context.getAppTheme().cardColor,
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 34.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null)
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: SvgPicture.asset(
                      icon!,
                      fit: BoxFit.contain,
                    ),
                  ),
                if (iconpng != null)
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Image.asset(
                      iconpng!,
                      fit: BoxFit.contain,
                    ),
                  ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.getTextTheme().titleMedium,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: context.getTextTheme().bodySmall,
                ),
                SizedBox(
                  height: 32.h,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  if (!hideNegative) ...[
                    Houtlinedbutton(
                      text: context.getLocalization()!.cancel,
                      onPressed: () => onCancelClikced(),
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                  ],
                  if (hideNegative)
                    Expanded(
                      child: HFilledButton(
                        text: buttonText,
                        onPressed: () => onButtonClikced(),
                      ),
                    )
                  else
                    HFilledButton(
                      text: buttonText,
                      onPressed: () => onButtonClikced(),
                    ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
