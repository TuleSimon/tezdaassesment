import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezdaassesment/features/core/theme/widgets/button/BackButton.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/products/presentation/pages/product_page.dart';
import 'package:tezdaassesment/features/modules/products/presentation/riverpod/product_provider.dart';

class FavouritesPage extends ConsumerStatefulWidget {
  const FavouritesPage({super.key});

  @override
  ConsumerState<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends ConsumerState<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    final currentProductState = ref.watch(productsProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(context.getLocalization()!.favourites),
          titleTextStyle: context.getTextTheme().titleMedium,
          centerTitle: false,
          leading: backButton(context),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            handleList(
                currentProductState.favourites,
                currentProductState.favourites,
                context,
                false,
                null,
                false,
                false, () {
              ref.read(productsProvider.notifier).getFavourites();
            })
          ],
        ));
  }
}
