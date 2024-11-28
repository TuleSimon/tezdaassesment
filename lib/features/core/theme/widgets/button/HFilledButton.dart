import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class HFilledButton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final bool? loading;
  final FontWeight? fontWeight;
  final Color? textColor;
  final VisualDensity? visualDensity;
  final Color? bgColor;
  final Color? tint;

  final bool? enabled;
  final TextAlign? align;
  final EdgeInsets? padding;

  final IconData? endIcon;
  final IconData? startIcon;
  final String? startIcon2;
  final String? endIcon2;

  final double? radius;
  final void Function()? onPressed;

  HFilledButton(
      {super.key,
      required this.text,
      this.fontSize,
      this.loading = false,
      this.fontWeight,
      this.textColor,
      this.bgColor,
      this.visualDensity,
      this.enabled = true,
      this.align,
      this.padding,
      this.endIcon,
      this.startIcon,
      this.startIcon2,
      this.endIcon2,
      this.radius,
      this.onPressed,
      this.tint})
      : super();

  @override
  Widget build(BuildContext context) {
    debugPrint(enabled.toString());
    return FilledButton(
      style: context.getAppTheme().filledButtonTheme.style?.copyWith(
          visualDensity: visualDensity,
          backgroundColor: WidgetStatePropertyAll(
              enabled == true && loading == false
                  ? bgColor ?? context.getAppTheme().colorScheme.primary
                  : (bgColor ?? context.getAppTheme().colorScheme.primary)
                      .withOpacity(0.4))),
      onPressed: () =>
          enabled != false && loading != true ? onPressed?.call() : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loading == true) ...[
            SizedBox(
              width: 15.w,
              height: 15.h,
              child: CircularProgressIndicator(
                color: context
                    .getAppTheme()
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(0.8),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          if (startIcon != null) ...[
            Icon(
              startIcon,
              color: tint,
              size: 18.w,
            ),
            SizedBox(
              width: 4.w,
            ),
          ],
          if (startIcon2 != null) ...[
            SvgPicture.asset(
              startIcon2!,
              colorFilter: tint != null
                  ? ColorFilter.mode(tint!, BlendMode.srcIn)
                  : null,
              width: 18.w,
              height: 18.w,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          Text(
            text,
            style: context.getTextTheme().titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: textColor ??
                    context
                        .getColorScheme()
                        .onSurfaceVariant
                        .withOpacity(enabled == true ? 1 : 0.4)),
          ),
          if (endIcon != null) ...[
            SizedBox(
              width: 4.w,
            ),
            Icon(
              endIcon,
              color: tint ?? context.getAppTheme().colorScheme.onSurfaceVariant,
              size: 17.w,
            )
          ],
          if (endIcon2 != null) ...[
            SvgPicture.asset(
              endIcon2!,
              colorFilter: ColorFilter.mode(
                  tint ?? context.getAppTheme().colorScheme.onSurfaceVariant,
                  BlendMode.srcIn),
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
