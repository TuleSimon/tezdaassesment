import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezdaassesment/features/core/theme/widgets/text/TextWithIcon.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class HTextField extends StatefulWidget {
  final String? title;
  final GlobalKey? widgetkey;
  final String? toolTip;
  final String? hint;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? padding;
  final Color? bg;
  final int? maxLength;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  final TextStyle? style;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final bool readOnly;
  final String? error;
  final BoxConstraints? constraints;

  final List<TextInputFormatter>? formatters;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Function(String, String?, String?)? onChange2;
  final TextAlign? titleAlign;
  final TextStyle? titleStyle;
  final bool? hideBorder;
  final void Function(String)? onSubmitted;
  final bool? obscureText;
  final String? obscureCharacter;
  final bool? hideBorderMain;
  final String? value;
  final TextInputAction? keyboardAction;

  const HTextField({
    super.key,
    this.title,
    this.controller,
    this.widgetkey,
    this.hint,
    this.keyboardType,
    this.onSubmitted,
    this.keyboardAction,
    this.style,
    this.bg,
    this.padding,
    this.suffixIcon,
    this.prefixIcon,
    this.hintStyle,
    this.formatters,
    this.readOnly = false,
    this.onTap,
    this.constraints,
    this.onChange,
    this.onChange2,
    this.titleAlign,
    this.titleStyle,
    this.toolTip,
    this.suffixIconConstraints,
    this.error,
    this.hideBorder = false,
    this.hideBorderMain = false,
    this.maxLength,
    this.obscureText = false,
    this.obscureCharacter = "*",
    this.value,
  });

  @override
  State<HTextField> createState() => _IkookTextFieldState();
}

class _IkookTextFieldState extends State<HTextField> {
  String inpit = "";
  late FocusNode myFocusNode = FocusNode();

  // Use it to change color for border when textFiled in focus
  FocusNode _focusNode = FocusNode();

// Color for border
  Color _borderColor = Colors.transparent;

  late final TextEditingController controller =
      widget.controller ?? TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(covariant HTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && controller.text != widget.value) {
      setState(() {
        controller.text = widget.value ?? "";
      });
    }
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Change color for border if focus was changed
    _focusNode.addListener(() {
      setState(() {
        _borderColor = _focusNode.hasFocus
            ? widget.error != null
                ? context.getColorScheme().error
                : context.getColorScheme().primary
            : Colors.transparent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: widget.widgetkey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: widget.hideBorder == true
                ? const Border.fromBorderSide(BorderSide.none)
                : Border.all(
                    color: widget.error != null
                        ? context.getColorScheme().error
                        : _borderColor),
            borderRadius: BorderRadius.circular(8.w),
            color: widget.bg ?? context.getColorScheme().surfaceContainer,
          ),
          padding: (widget.padding ??
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h).copyWith(
                  top: ((_focusNode.hasFocus ||
                              controller.text.isNotEmpty == true) &&
                          widget.hideBorder != true)
                      ? 10.h
                      : 5.h)),
          child: TextField(
            controller: controller,
            readOnly: widget.readOnly,
            focusNode: _focusNode,
            obscureText: widget.obscureText ?? false,
            obscuringCharacter: widget.obscureCharacter ?? "*",
            onSubmitted: widget.onSubmitted,
            onTap: widget.onTap,
            onChanged: (e) {
              widget.onChange?.call(e);
            },
            keyboardType: widget.formatters
                        ?.contains(FilteringTextInputFormatter.digitsOnly) ==
                    true
                ? const TextInputType.numberWithOptions(
                    signed: true, decimal: true)
                : null,
            maxLength: widget.maxLength,
            inputFormatters: widget.formatters,
            style: widget.style ?? context.getTextTheme().bodyMedium,
            decoration: InputDecoration(
              constraints:
                  widget.constraints ?? BoxConstraints(minHeight: 30.h),
              fillColor: widget.bg ?? context.getColorScheme().surfaceContainer,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
              label: widget.title != null
                  ? Text(
                      widget.title ?? "",
                      style: context.getTextTheme().bodySmall,
                    )
                  : null,
              hintText: widget.hint,
              hintStyle: widget.hintStyle ?? context.getTextTheme().bodySmall,
              prefixIcon: widget.prefixIcon,
              prefixIconColor:
                  context.getColorScheme().onSurface.withOpacity(0.6),
              prefixIconConstraints: BoxConstraints.loose(Size.fromWidth(20.w)),
              suffixIcon: widget.suffixIcon,
              suffixIconColor:
                  context.getColorScheme().onSurface.withOpacity(0.6),
              suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(20.w)),
              focusedBorder: OutlineInputBorder(
                borderRadius: widget.hideBorder == true
                    ? BorderRadius.zero
                    : BorderRadius.circular(8),
                borderSide: widget.hideBorder == true
                    ? const BorderSide(color: Colors.transparent, width: 0)
                    : BorderSide(width: 0.w, color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: widget.hideBorder == true
                    ? BorderRadius.zero
                    : BorderRadius.circular(8),
                borderSide: widget.hideBorder == true
                    ? const BorderSide(color: Colors.transparent, width: 0)
                    : BorderSide(width: 0.w, color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                borderRadius: widget.hideBorder == true
                    ? BorderRadius.zero
                    : BorderRadius.circular(8),
                borderSide: widget.hideBorder == true
                    ? const BorderSide(color: Colors.transparent, width: 0)
                    : BorderSide(width: 0.w, color: Colors.transparent),
              ),
            ),
          ),
        ),
        if (widget.error != null) ...[
          SizedBox(
            height: 5.h,
          ),
          HTextWithIcon(
            text: widget.error!,
            isExpanded: true,
            align: TextAlign.start,
            iconSize: 12.w,
            maxLines: 2,
            tint: context.getColorScheme().error,
            icon: Icons.error_outline,
            style: context.getTextTheme().bodySmall?.copyWith(
                fontSize: 12.sp, color: context.getColorScheme().error),
          )
        ]
      ],
    );
  }
}
