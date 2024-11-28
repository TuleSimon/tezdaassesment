import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezdaassesment/features/core/assets/AssetsManager.dart';
import 'package:tezdaassesment/features/core/theme/hegmof_theme.dart';
import 'package:tezdaassesment/features/core/theme/widgets/cards/HEmptyCard.dart';
import 'package:tezdaassesment/features/core/theme/widgets/skeleton/HSkeleton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/textfields/HTextFields.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/products/domain/entities/product_entity.dart';
import 'package:tezdaassesment/features/modules/products/presentation/riverpod/category_provider.dart';
import 'package:tezdaassesment/features/modules/products/presentation/riverpod/product_provider.dart';
import 'package:tezdaassesment/features/modules/products/presentation/widgets/product_widget.dart';
import 'package:tezdaassesment/features/modules/profile/presentation/provider/profile_provider.dart';

class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key});

  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  final GlobalKey supportTextKey = GlobalKey();
  double textFieldHeight = 60.h;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          supportTextKey.currentContext?.findRenderObject() as RenderBox;
      if (renderBox != null && renderBox.size.height != textFieldHeight) {
        setState(() {
          textFieldHeight = renderBox.size.height;
        });
      }
      ref.read(profileProvider.notifier).refreshProfile();
    });
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    final state = ref.read(productsProvider);
    if (controller.offset >= controller.position.maxScrollExtent * 1 &&
        !controller.position.outOfRange &&
        !state.loading &&
        state.products.length >= 10) {
      debugPrint("Reached End of list");
      ref.read(productsProvider.notifier).getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final expandedHeight = kToolbarHeight + textFieldHeight + 40.h;
    final productsNotifier = ref.watch(productsProvider.notifier);
    final currentProductState = ref.watch(productsProvider);
    ref.listen(categoryProvider, (prev, next) {
      if (prev?.activeCategoryId != -1 && next.activeCategoryId == -1) {
        controller.animateTo(controller.initialScrollOffset,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        productsNotifier.selectCategory(null);
      } else if (prev?.activeCategoryId != next.activeCategoryId &&
          next.activeCategoryId != -1) {
        controller.animateTo(controller.initialScrollOffset,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        productsNotifier.selectCategory(next.activeCategoryId);
      }
    });

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(productsProvider.notifier).getProducts();
          ref.read(categoryProvider.notifier).getCategories();
        },
        child: CustomScrollView(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: context.getColorScheme().primary,
              centerTitle: false,
              leading: Padding(
                padding: EdgeInsets.only(left: horizontalPadding.left),
                child: SvgPicture.asset(
                  AllAppAssets.MarketIcon.getPath(),
                  width: 24.w,
                  height: 24.w,
                ),
              ),
              leadingWidth: 46.w,
              pinned: true,
              expandedHeight: kToolbarHeight +
                  context.getTopPadding() +
                  (textFieldHeight - 20),
              title: Text(context.getLocalization()!.products),
              titleTextStyle: context
                  .getTextTheme()
                  .titleMedium
                  ?.copyWith(color: context.getColorScheme().onPrimary),
              flexibleSpace: textFieldSpace(expandedHeight, (query) {
                productsNotifier.searchProducts(query);
              }),
            ),
            Consumer(
              builder: (context, ref, child) {
                final currentState = ref.watch(categoryProvider);
                return SliverAppBar(
                  primary: false,
                  backgroundColor: context.getColorScheme().primary,
                  automaticallyImplyLeading: false,
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: currentState.loading
                        ? Row(
                            children: List.generate(10, (ge) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: categoryTab(
                                  false,
                                  name: "loading",
                                  context,
                                  () {},
                                  loading: true,
                                ),
                              );
                            }),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              categoryTab(
                                currentState.activeCategoryId == -1,
                                name: context.getLocalization()!.all,
                                context,
                                () {
                                  ref
                                      .read(categoryProvider.notifier)
                                      .selectCategory(null);
                                },
                              ),
                              SizedBox(width: 10.w),
                              ...currentState.categories.map(
                                (category) => Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: categoryTab(
                                    currentState.activeCategoryId ==
                                        category.id,
                                    name: category.name,
                                    context,
                                    () {
                                      ref
                                          .read(categoryProvider.notifier)
                                          .selectCategory(category.id);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                  shadowColor: context.getColorScheme().primary,
                  surfaceTintColor: context.getColorScheme().primary,
                  scrolledUnderElevation: 0,
                  pinned: true,
                );
              },
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 20.h,
            )),
            handleList(
                currentProductState.products ?? [],
                currentProductState.favourites,
                context,
                currentProductState.loading,
                currentProductState.error,
                currentProductState.network,
                currentProductState.poorNetwork, () {
              ref.read(productsProvider.notifier).getProducts();
              ref.read(categoryProvider.notifier).getCategories();
            }),
            if (currentProductState.loading &&
                currentProductState.products.length >= 10) ...[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.w,
                  width: 24.w,
                  child: const FittedBox(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 30.h,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget textFieldSpace(double expandedHeight, Function(String) onChange) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fraction = max(0, constraints.biggest.height - kToolbarHeight) /
            (expandedHeight - kToolbarHeight);
        debugPrint(fraction.toString());

        return FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(
            left: horizontalPadding.left,
            right: horizontalPadding.right,
            top:
                max(0, 55.h * (1 + fraction)), // Ensure padding is non-negative
          ),
          stretchModes: const [StretchMode.fadeTitle],
          title: fraction > 0.6
              ? Opacity(
                  opacity: min(max(0, fraction),
                      1), // Adjust the opacity to show/hide TextField
                  child: Row(
                    children: [
                      Expanded(
                        child: HTextField(
                          widgetkey: supportTextKey,
                          suffixIcon: Icon(
                            Icons.search,
                            size: 12.w,
                            color: context.getColorScheme().onSurface,
                          ),
                          onSubmitted: (value) {
                            onChange(value);
                          },
                          onChange: (query) {
                            onChange(query);
                          },
                          keyboardType: TextInputType.text,
                          keyboardAction: TextInputAction.search,
                          constraints: BoxConstraints(maxHeight: 35.h),
                          style: context.getTextTheme().bodySmall?.copyWith(
                              color: context.getColorScheme().onSurface,
                              decorationThickness: 0,
                              decoration: TextDecoration.none),
                          bg: context.getColorScheme().onPrimary,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          hintStyle: context.getTextTheme().bodySmall?.copyWith(
                              color: context.getColorScheme().onSurface,
                              fontSize: 10.sp),
                          hint: "Search products...",
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}

Widget handleList(
    List<ProductEntity> item,
    List<ProductEntity> favourites,
    BuildContext context,
    bool loading,
    String? error,
    bool? networkError,
    bool? timeOutError,
    VoidCallback onRefresh) {
  final errorMessage = error ??
      (networkError == true
          ? context.getLocalization()!.turn_on_your_internet_connection
          : timeOutError == true
              ? context.getLocalization()!.poor_slow_network
              : null);

  return (loading && item.isEmpty)
      ? SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Two items per row
            mainAxisSpacing: 20.w, // Spacing between rows
            crossAxisSpacing: 20.h, // Spacing between columns
            childAspectRatio: 1 / 1, // Width to height ratio
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: 20.h,
                  left: horizontalPadding.left,
                  right: horizontalPadding.right),
              child: const ProductWidget(
                entity: null,
              ),
            );
          },
          itemCount: 10,
        )
      : (errorMessage != null && item.isEmpty)
          ? SliverToBoxAdapter(
              child: HErrorCard(
                  noun: context.getLocalization()!.products,
                  custom: errorMessage.parseError(context),
                  icon: AllAppAssets.MarketIcon.getPath(),
                  action: () {
                    onRefresh();
                  }))
          : item.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                  padding: EdgeInsets.only(top: context.getSize().height * 0.2),
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: HEmptyCard(
                      noun: context.getLocalization()!.products,
                      icon: AllAppAssets.MarketIcon.getPath(),
                    ),
                  ),
                ))
              : SliverPadding(
                  padding: horizontalPadding,
                  sliver: SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Two items per row
                      mainAxisSpacing: 20.w, // Spacing between rows
                      crossAxisSpacing: 20.h, // Spacing between columns
                      childAspectRatio: 1 / 1, // Width to height ratio
                    ),
                    itemBuilder: (context, index) {
                      final itemEntity = item.getOrNull(index);
                      if (itemEntity == null) return null;
                      return ProductWidget(
                        entity: itemEntity,
                      );
                    },
                    itemCount: item.length,
                  ),
                );
}

Widget categoryTab(bool isActive, BuildContext context, VoidCallback onClick,
    {required String name, bool loading = false}) {
  return HSkeleton(
    isLoading: loading,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: isActive
            ? const Color(0xFFAB6B0D)
            : context.getColorScheme().surfaceContainer,
        border: isActive
            ? Border.fromBorderSide(
                BorderSide(color: context.getColorScheme().primary))
            : const Border.fromBorderSide(BorderSide.none),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Text(
          name,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: context.getTextTheme().bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: isActive
                    ? context.getColorScheme().onPrimary
                    : context.getColorScheme().onSurface,
              ),
        ),
      ),
    ),
  );
}
