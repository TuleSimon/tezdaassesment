abstract interface class AbstractRoutes {
  final String route;
  final String? routeWithArgs;
  final String? title;

  const AbstractRoutes.create(this.route, {this.title, this.routeWithArgs});

  factory AbstractRoutes(String route, {String? routeWithArgs}) =>
      _AppRoutes(route, routeWithArgs: routeWithArgs);
}

class _AppRoutes implements AbstractRoutes {
  final String route;
  final String? title;
  final String? routeWithArgs;

  const _AppRoutes(this.route, {this.title, this.routeWithArgs}) : super();
}

class AppRoutes {
  static final OnboardingHomeScreen = _AppRoutes("/onboarding");
  static final HomeScreen = _AppRoutes("/homeScreen");
  static final FavouritesRoute = _AppRoutes("/favourites");
  static final ProfileRoute = _AppRoutes("/profile");
  static final LoginScreen = _AppRoutes("/login");
  static final Register = _AppRoutes("/register");
  static final ViewProfile = _AppRoutes("/view_profile");
  static final ProductDetailsPage = _AppRoutes(
    "/view_product",
    routeWithArgs: "/view_product/:$IdParam/:$ImageParam",
  );

  /**
   * AUTHENTICATION SCREENS
   */
}

const orderIdParam = "orderId";
const IdParam = "idParam";
const ImageParam = "imageParam";
