import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class Houtlinedbutton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool? loading;
  final FontWeight? fontWeight;
  final Color? textColor;
  final VisualDensity? visualDensity;
  final Color? bgColor;
  final Color? borderColor;

  final bool? enabled;
  final TextAlign? align;
  final EdgeInsets? padding;

  final IconData? endIcon;
  final IconData? startIcon;
  final String? startIcon2;
  final String? endIcon2;

  final double? radius;
  final void Function()? onPressed;

  Houtlinedbutton(
      {super.key,
      required this.text,
      this.fontSize,
      this.loading = false,
      this.fontWeight,
      this.textColor,
      this.visualDensity,
      this.bgColor,
      this.borderColor,
      this.enabled = true,
      this.align,
      this.padding,
      this.endIcon,
      this.startIcon,
      this.startIcon2,
      this.endIcon2,
      this.radius,
      this.onPressed})
      : super();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: context.getAppTheme().outlinedButtonTheme.style?.copyWith(
          visualDensity: visualDensity,
          padding: WidgetStatePropertyAll(padding),
          backgroundColor: WidgetStatePropertyAll(
              enabled == true && loading == false
                  ? bgColor ?? context.getAppTheme().cardColor
                  : (bgColor ?? context.getAppTheme().colorScheme.onSurface)
                      .withOpacity(0.4)),
          side: WidgetStatePropertyAll(BorderSide(
              color: enabled == true && loading == false
                  ? borderColor ?? context.getAppTheme().colorScheme.primary
                  : (borderColor ?? context.getAppTheme().colorScheme.primary)
                      .withOpacity(0.4)))),
      onPressed: () => enabled == true ? onPressed?.call() : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loading == true) ...[
            SizedBox(
              width: 15.w,
              height: 15.h,
              child: CircularProgressIndicator(
                color: context.getAppTheme().colorScheme.primary,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          if (startIcon != null) ...[
            Icon(
              startIcon,
              color: context.getAppTheme().colorScheme.primary,
              size: 18.w,
            ),
            SizedBox(
              width: 4.w,
            ),
          ],
          if (startIcon2 != null) ...[
            SvgPicture.asset(
              startIcon2!,
              colorFilter: ColorFilter.mode(
                  context.getAppTheme().colorScheme.primary, BlendMode.srcIn),
              width: 18.w,
              height: 18.w,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 4.w,
            ),
          ],
          Text(
            text,
            style: context.getTextTheme().headlineMedium?.copyWith(
                fontSize: fontSize,
                color: textColor ?? context.getColorScheme().primary),
          ),
          if (endIcon != null) ...[
            SizedBox(
              width: 4.w,
            ),
            Icon(
              endIcon,
              color: context.getAppTheme().colorScheme.primary,
              size: 17.w,
            )
          ],
          if (endIcon2 != null) ...[
            SvgPicture.asset(
              endIcon2!,
              colorFilter: ColorFilter.mode(
                  context.getAppTheme().colorScheme.primary, BlendMode.srcIn),
              width: 18.w,
              height: 18.w,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 4.w,
            ),
          ],
        ],
      ),
    );
  }
}
