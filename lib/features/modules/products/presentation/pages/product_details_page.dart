import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezdaassesment/features/core/theme/hegmof_theme.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/BackButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/HFilledButton.dart';
import 'package:tezdaassesment/features/core/theme/widgets/skeleton/HSkeleton.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/products/presentation/riverpod/product_provider.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final String productId;
  final String firstImageUrl;

  const ProductDetailsPage(
      {super.key, required this.productId, required this.firstImageUrl});

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductDetailsPage> {
  final GlobalKey supportTextKey = GlobalKey();

  final PageController _pageController = PageController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productsProvider.notifier).getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentState = ref.watch(productsProvider);
    final product = currentState.productDetails;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref
              .read(productsProvider.notifier)
              .getProductDetails(widget.productId);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: context.getColorScheme().primary,
              centerTitle: false,
              leading: Padding(
                padding: EdgeInsets.only(left: horizontalPadding.left),
                child: backButton(context),
              ),
              leadingWidth: 46.w,
              pinned: true,
              title: Text(context.getLocalization()!.view_product),
              titleTextStyle: context
                  .getTextTheme()
                  .titleMedium
                  ?.copyWith(color: context.getColorScheme().onPrimary),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 300.h,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                    itemCount: product?.images.length ?? 1,
                    pageSnapping: true,
                    onPageChanged: (page) {
                      setState(() {
                        index = page;
                      });
                    },
                    controller: _pageController,
                    itemBuilder: (context, pagePosition) {
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.w)),
                        margin: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          cacheKey: product == null
                              ? widget.firstImageUrl
                              : product!.images[pagePosition],
                          imageUrl: product == null
                              ? widget.firstImageUrl
                              : product!.images[pagePosition],
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...indicators(
                      product == null ? 1 : product!.images.length, index)
                ],
              ),
            ),
            SliverPadding(
              padding: horizontalPadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    HSkeleton(
                      isLoading: currentState.productDetailsLoading == true,
                      child: Text(
                        product?.title ?? "Loading descrfiot",
                        style: context.getTextTheme().titleLarge,
                      ),
                    ),
                    HSkeleton(
                        isLoading: currentState.productDetailsLoading == true,
                        child: Text(
                          product?.category?.name ?? "Loading descrfiot",
                          style: context.getTextTheme().bodySmall,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    HSkeleton(
                        isLoading: currentState.productDetailsLoading == true,
                        child: Text(
                          product?.description ??
                              "Loading description this should be a rather long test of some nonse stuff",
                          style: context.getTextTheme().bodyLarge,
                        )),
                    SizedBox(
                      height: 25.h,
                    ),
                    if (currentState.favourites
                            .any((re) => re.id == product?.id) ==
                        true)
                      HFilledButton(
                        text: context.getLocalization()!.remove_from_favourite,
                        loading: currentState.productDetailsLoading,
                        onPressed: () {
                          ref
                              .read(productsProvider.notifier)
                              .removeFavourites(product!);
                          context
                              .showSuccess(context.getLocalization()!.removed);
                        },
                      )
                    else
                      HFilledButton(
                        text: context.getLocalization()!.add_to_favourote,
                        loading: currentState.productDetailsLoading,
                        onPressed: () {
                          ref
                              .read(productsProvider.notifier)
                              .addFavourites(product!);
                          context.showSuccess(
                              context.getLocalization()!.added_to_fav);
                        },
                      ),
                    SizedBox(
                      height: context.getBottomPadding(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3.w),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }
}
