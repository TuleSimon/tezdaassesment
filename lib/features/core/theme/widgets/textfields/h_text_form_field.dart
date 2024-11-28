import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezdaassesment/features/core/theme/widgets/text/TextWithIcon.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class HTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChange;
  final String? hint;
  final String? error;
  final TextStyle? hintStyle;

  const HTextFormField(
      {super.key,
      this.controller,
      this.onChange,
      this.hint,
      this.hintStyle,
      this.error})
      : super();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        controller: controller,
        onChanged: onChange,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlignVertical: TextAlignVertical.top,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        minLines: 10,
        maxLines: null,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
          fillColor: context.getColorScheme().surfaceContainer,
          filled: true,
          error: error != null
              ? HTextWithIcon(
                  text: error!,
                  isExpanded: true,
                  align: TextAlign.start,
                  iconSize: 12.w,
                  maxLines: 2,
                  tint: context.getColorScheme().error,
                  icon: Icons.error_outline,
                  style: context.getTextTheme().bodySmall?.copyWith(
                      fontSize: 12.sp, color: context.getColorScheme().error),
                )
              : null,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.w),
            borderSide:
                BorderSide(width: 1.w, color: context.getColorScheme().error),
          ),
          hintText: hint,
          hintStyle: hintStyle ?? context.getTextTheme().bodySmall,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 0.w, color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.w),
            borderSide: BorderSide(
                width: 1.w,
                color: error != null
                    ? context.getColorScheme().error
                    : context.getColorScheme().surfaceContainer),
          ),
        ),
      ),
    ]);
  }
}
