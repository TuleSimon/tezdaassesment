import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tezdaassesment/features/core/theme/app_theme.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HFilledButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HOutlinedButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/layouts/ScollableColumn.dart';
import 'package:tezdaassesment/features/core/theme/widgets/text/TextWithIcon.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class GenericBottomSheet extends StatelessWidget {
  final String title;
  final String body;
  final String actionText;
  final String? subactionText;
  final VoidCallback onAction;
  final VoidCallback? subonAction;
  final String? icon;
  final IconData? iconData;
  final Color? tint;
  final Widget? extraWidget;

  const GenericBottomSheet(
      {super.key,
      required this.title,
      required this.body,
      required this.actionText,
      required this.onAction,
      this.icon,
      this.subactionText,
      this.subonAction,
      this.tint,
      this.extraWidget,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding.copyWith(top: 20.h, bottom: 20.h),
      child: HScollableColumn(
          wrap: true,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              SvgPicture.asset(
                icon!,
                width: 50.w,
                height: 50.h,
              ),
            if (iconData != null)
              Icon(
                iconData,
                size: 30.w,
                color: tint,
              ),
            SizedBox(
              height: 5.h,
            ),
            Text(title, style: context.getTextTheme().titleMedium),
            SizedBox(
              height: 10.h,
            ),
            Text(
              body,
              style: context.getTextTheme().bodySmall,
              textAlign: TextAlign.center,
            ),
            if (extraWidget != null) ...[
              SizedBox(
                height: 16.h,
              ),
              extraWidget!
            ],
            SizedBox(
              height: 30.h,
            ),
            HFilledButton(
                text: actionText,
                onPressed: () async {
                  Navigator.of(context).pop();
                  onAction();
                }),
            if (subonAction != null && subactionText != null) ...[
              SizedBox(
                height: 10.h,
              ),
              Houtlinedbutton(
                  text: subactionText!,
                  onPressed: () async {
                    Navigator.of(context).pop();
                    subonAction!();
                  })
            ]
          ]),
    );
  }
}

Widget selectImageSourceSheet(
    BuildContext context, Function(File) onImagePicked) {
  void parseResult(Either<String, File?> result) {
    result.fold((err) {
      if (err == NO_IMAGE_SELECTED) {
        context.showError("No image selected");
      } else if (err == IMAGE_SIZE_TOO_LARGE) {
        context.showError("Image size is too large");
      } else {
        context.showError(context.getLocalization()!.something_went_wrong);
      }
      context.pop();
    }, (file) {
      if (file != null) {
        onImagePicked(file);
        context.pop(file);
      }
    });
  }

  return Padding(
    padding: horizontalPadding.copyWith(top: 20.h, bottom: 20.h),
    child: Column(
      children: [
        InkWell(
          onTap: () async {
            final result = await AppImagePicker.pickImageFromSource(true);
            parseResult(result);
          },
          child: HTextWithIcon(
            text: "Camera",
            icon: Icons.camera_alt_rounded,
            tint: context.getColorScheme().onSurface,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Divider(
          color: context.getColorScheme().surfaceContainer,
        ),
        SizedBox(
          height: 10.h,
        ),
        InkWell(
          onTap: () async {
            final result = await AppImagePicker.pickImageFromSource(false);
            parseResult(result);
          },
          child: HTextWithIcon(
            text: "Gallery",
            icon: Icons.image_outlined,
            tint: context.getColorScheme().onSurface,
          ),
        ),
      ],
    ),
  );
}

const NO_IMAGE_SELECTED = '1001';
const IMAGE_SIZE_TOO_LARGE = '1002';

class AppImagePicker {
  static final ImagePicker _picker = ImagePicker();

  static Future<double> _getXFileSizeInMB(XFile file) async {
    // Get the file size in bytes directly from XFile
    int fileSizeInBytes = await file.length() ?? 0;

    // Convert bytes to megabytes
    double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

    // Format to two decimal places
    return double.parse(fileSizeInMB.toStringAsFixed(2));
  }

  static Future<Either<String, File?>> pickImageFromSource(
      bool isCamera) async {
    final XFile? photo = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (photo == null) return const Left(NO_IMAGE_SELECTED);
    double size = await _getXFileSizeInMB(photo);
    if (size < 4.1) {
      return Right(File(photo.path));
    } else {
      return const Left(IMAGE_SIZE_TOO_LARGE);
    }
  }
}
