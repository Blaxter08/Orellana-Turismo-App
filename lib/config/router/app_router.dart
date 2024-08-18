import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_app/presentation/screens/screens.dart';

import '../../presentation/views/splash/splash_view.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashView(
          onSplashFinished: () {
            Future.delayed(Duration(seconds: 2), () {
              context.go('/login');
            });
          },
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/ayuda',
      builder: (context, state) => AyudaScreen(),
    ),
    GoRoute(
      path: '/ajustes',
      builder: (context, state) => AjustesScreen(),
    ),
    GoRoute(
      path: '/editar-cuenta',
      builder: (context, state) => UserProfileScreen(),
    ),
  ],
);
