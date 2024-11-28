import 'package:equatable/equatable.dart';

sealed class BaseNetworkroutes extends Equatable {
  final String route;

  const BaseNetworkroutes(this.route);
}

const _BASE_URL = "https://api.escuelajs.co/api/v1/";

class Networkroutes {
  static const loginUrl = _AppNetworkRoutes("auth/login");
  static const getProfile = _AppNetworkRoutes("auth/profile");
  static const getCategories = _AppNetworkRoutes("categories");
  static const getProducts = _AppNetworkRoutes("products");
  static const updatePicture = _AppNetworkRoutes("files/upload");
  static const registerUser = _AppNetworkRoutes("users");
  static const isEmailAvailable = _AppNetworkRoutes("users/is-available");
}

class _AppNetworkRoutes extends BaseNetworkroutes {
  final String _routes;

  const _AppNetworkRoutes(this._routes) : super(_BASE_URL + _routes);

  @override
  List<Object?> get props => [_routes, super.route];
}
