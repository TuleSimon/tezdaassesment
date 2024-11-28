import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tezdaassesment/features/core/theme/widgets/cards/GradientCard.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

Widget backButton(BuildContext context) {
  return InkWell(
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
  );
}
