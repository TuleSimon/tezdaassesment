import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezdaassesment/features/core/assets/AssetsManager.dart';
import 'package:tezdaassesment/features/core/theme/widgets/image/HNetworkImage.dart';
import 'package:tezdaassesment/features/core/theme/widgets/skeleton/HSkeleton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/text/SideBySideText.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/core/utils/money_extensions.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity? entity;

  const ProductWidget({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return HSkeleton(
      isLoading: entity == null,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.w),
            border: Border.fromBorderSide(BorderSide(
                color: context.getColorScheme().onSurface.withOpacity(0.2)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hnetworkimage(
                width: double.maxFinite,
                fit: BoxFit.cover,
                image: entity?.images.firstOrNull ?? "",
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: HSidebySideWidget(
                left: Text(
                  entity?.price.parseCurrency() ?? "loading",
                  style: context.getTextTheme().headlineLarge,
                ),
                right: SvgPicture.asset(
                  AllAppAssets.addToFavourite.getPath(),
                  width: 34.w,
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                entity?.title ?? "loading",
                maxLines: 2,
                style: context.getTextTheme().titleMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                entity?.description ?? "loading",
                maxLines: 4,
                style: context.getTextTheme().bodySmall,
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
