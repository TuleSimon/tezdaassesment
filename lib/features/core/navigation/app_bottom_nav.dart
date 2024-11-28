import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezdaassesment/features/core/assets/AssetsManager.dart';
import 'package:tezdaassesment/features/core/navigation/routes.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    Key? key,
    required this.path,
  }) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    final items = [
      BottomNavItem(
          title: context.getLocalization()!.home,
          route: AppRoutes.HomeScreen,
          asset: AllAppAssets.BN_HomeIcon.getPath()),
      BottomNavItem(
          title: context.getLocalization()!.favourites,
          route: AppRoutes.FavouritesRoute,
          asset: AllAppAssets.BN_Favourite.getPath()),
      BottomNavItem(
          title: context.getLocalization()!.profile,
          route: AppRoutes.ProfileRoute,
          asset: AllAppAssets.BN_Profile.getPath()),
    ];

    final selectedIndex =
        items.indexWhere((element) => element.route.route == path);

    return BottomNavigationBar(
        backgroundColor: context.getColorScheme().surface,
        onTap: (index) {
          final route = items[index];
          context.goToScreen(route.route);
        },
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        iconSize: 30.w,
        unselectedFontSize: 12.sp,
        selectedFontSize: 12.sp,
        selectedIconTheme:
            IconThemeData(color: context.getColorScheme().primary),
        selectedItemColor: context.getColorScheme().primary,
        currentIndex: selectedIndex,
        unselectedItemColor: context.getColorScheme().onSurface,
        showUnselectedLabels: true,
        items: items
            .map((menu) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  menu.asset,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                      selectedIndex == items.indexOf(menu)
                          ? context.getColorScheme().primary
                          : context.getColorScheme().onSurface,
                      BlendMode.srcIn),
                ),
                label: menu.title,
                backgroundColor: context.getColorScheme().surface))
            .toList());
  }
}

class BottomNavItem extends Equatable {
  final String title;
  final AbstractRoutes route;
  final String asset;

  const BottomNavItem({
    required this.title,
    required this.route,
    required this.asset,
  });

  @override
  List<Object> get props => [title, route, asset];
}
