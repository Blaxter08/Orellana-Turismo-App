import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_app/presentation/screens/introduccion/introduccion_screen.dart';
import 'package:turismo_app/presentation/screens/screens.dart';
import '../../presentation/screens/tutorial/tutorial_screen.dart';
import '../../presentation/views/splash/splash_view.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/tutorial',
      builder: (context, state) => const TutorialScreen(),
    ),
    GoRoute(
      path: '/routes_turisticas',
      builder: (context, state) => RutasTuristicasScreen(),
    ),
    GoRoute(
      path: '/route_detail',
      builder: (context, state) => RutaDetalleScreen(rutaId: ''),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/guide',
      builder: (context, state) => TouristGuideScreen(),
    ),
    GoRoute(
      path: '/ayuda',
      builder: (context, state) => const AyudaScreen(),
    ),
    GoRoute(
      path: '/ajustes',
      builder: (context, state) =>  AjustesScreen(),
    ),
    GoRoute(
      path: '/editar-cuenta',
      builder: (context, state) =>  UserProfileScreen(),
    ),
  ],
);
