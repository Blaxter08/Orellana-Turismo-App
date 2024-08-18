import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:turismo_app/config/router/app_router.dart';
import 'package:turismo_app/config/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light:ThemeData.light(),
        dark: ThemeData(
          dividerTheme: DividerThemeData(
            color: Colors.grey
          ),
          dividerColor: Colors.white60,
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey[900], // Color primario oscuro
          hintColor: Colors.blueGrey[600], // Color de acento oscuro
          scaffoldBackgroundColor: Colors.blueGrey[800], // Color de fondo del scaffold oscuro
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blueGrey[900], // Color del AppBar en el tema oscuro
            // elevation: 3,
          ),
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.blue[900],
          ),
          navigationDrawerTheme: NavigationDrawerThemeData(
            backgroundColor: Colors.blueGrey[600]
          ),
          drawerTheme: DrawerThemeData(
              backgroundColor: Colors.blueGrey[800]
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.blueGrey[900]
          ),
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme , darkTheme){
          return MaterialApp.router(
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
            title: 'Explora Orellana',
            theme:theme,
            darkTheme: darkTheme,
          );
        }
    );
  }
}