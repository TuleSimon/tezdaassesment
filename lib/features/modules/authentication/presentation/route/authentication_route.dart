import 'package:go_router/go_router.dart';
import 'package:tezdaassesment/features/core/navigation/go_router.dart';
import 'package:tezdaassesment/features/core/navigation/routes.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/pages/login_screen.dart';
import 'package:tezdaassesment/features/modules/authentication/presentation/pages/registration_screen.dart';

final authenticationRoutes = [
  GoRoute(
      path: AppRoutes.LoginScreen.route,
      pageBuilder: (context, state) =>
          getTransition(const Loginscreen(), state)),
  GoRoute(
      path: AppRoutes.Register.route,
      pageBuilder: (context, state) =>
          getTransition(const RegistrationScreen(), state)),
];
