import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/config/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'generated/l10n.dart';
import 'firebase_options.dart';
import 'infrastructure/services/notificacion/notificacion_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inicializa las notificaciones push
  await NotificationService.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString('language') ?? 'en';

  runApp(ProviderScope(child: MyApp(languageCode: languageCode)));
}

class MyApp extends StatefulWidget {
  final String languageCode;

  MyApp({required this.languageCode});

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    _locale = Locale(widget.languageCode);
    super.initState();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(),
      dark: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade600,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        brightness: Brightness.dark,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          title: 'Explora Orellana',
          theme: theme,
          darkTheme: darkTheme,
          locale: _locale,
          localizationsDelegates: [
            S.delegate,  // Asegúrate de que este delegado está presente
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,  // Usar los locales soportados por la clase S
        );
      },
    );
  }
}
