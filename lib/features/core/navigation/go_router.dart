import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tezdaassesment/features/core/navigation/app_bottom_nav.dart';
import 'package:tezdaassesment/features/core/navigation/routes.dart';
import 'package:tezdaassesment/features/core/utils/extensions.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/route/authentication_route.dart';
import 'package:tezdaassesment/features/modules/common/model/loggedin_user.dart';
import 'package:tezdaassesment/features/modules/common/shared_prefs/preference_manager.dart';
import 'package:tezdaassesment/features/modules/onboarding/presentation/pages/OnboardingHomeScreen.dart';
import 'package:tezdaassesment/features/modules/products/presentation/pages/product_page.dart';

GlobalKey<NavigatorState> parentKey = GlobalKey<NavigatorState>();
StreamSubscription<LoggedInUser?>? subscription;
GoRouter appRouter = GoRouter(
  navigatorKey: parentKey,
  routes: [
    ...authenticationRoutes,
    GoRoute(
        path: AppRoutes.OnboardingHomeScreen.route,
        pageBuilder: (context, state) =>
            getTransition(const Onboardinghomescreen(), state)),
    ShellRoute(
      parentNavigatorKey: parentKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return Scaffold(
            body: child,
            bottomNavigationBar:
                AppBottomNavigation(path: state.fullPath ?? ""));
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.HomeScreen.route,
          builder: (BuildContext context, GoRouterState state) {
            return const ProductPage();
          },
        ),
        GoRoute(
          path: AppRoutes.FavouritesRoute.route,
          builder: (BuildContext context, GoRouterState state) {
            return SizedBox();
          },
        ),
        GoRoute(
          path: AppRoutes.ProfileRoute.route,
          builder: (BuildContext context, GoRouterState state) {
            return SizedBox();
          },
        ),
      ],
    ),
  ],
  initialLocation: AppRoutes.OnboardingHomeScreen.route,
  redirect: (context, state) async {
    final sharedPresfs = GetIt.instance<PreferenceManager>();
    final user = await sharedPresfs.getUserData();
    debugPrint("Checking User ${state.fullPath}");
    final router = GetIt.instance<GoRouter>();
    await subscription?.cancel();
    subscription = sharedPresfs.getLoggedInUserStream().listen((user) {
      final isInAUthScreen = [AppRoutes.LoginScreen]
              .map((route) => route.route)
              .firstWhereOrNull((route) {
            debugPrint(route);
            return route == state.path;
          }) !=
          null;
      if (user == null && !isInAUthScreen) {
        router.go(AppRoutes.OnboardingHomeScreen.route);
        subscription?.cancel();
        parentKey = GlobalKey<NavigatorState>();
      }
    });
    if (user != null &&
        state.fullPath == AppRoutes.OnboardingHomeScreen.route) {
      debugPrint("Onboarding");
      return AppRoutes.HomeScreen.route;
    }
    return null;
  },
);

getTransition(Widget screen, GoRouterState state) {
  return CustomTransitionPage(
      key: state.pageKey,
      child: screen,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 2.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}
