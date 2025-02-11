import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Verificar si el usuario está logueado o si ha visto el tutorial
    _checkAppFlow();
  }

  Future<void> _checkAppFlow() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool seenTutorial = prefs.getBool('seenTutorial') ?? false;
    final String? uid = prefs.getString('uid');

    await Future.delayed(Duration(seconds: 2)); // Simular una pequeña carga

    if (!seenTutorial) {
      context.go('/tutorial');
    } else if (uid == null) {
      context.go('/login');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen central
              Image.asset(
                'assets/logos/coca_vivelo.png',
                height: 150, // Tamaño ajustado
              ),
              SizedBox(height: 20),
              // Fila de dos imágenes más pequeñas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logos/GADMFO-03.png',
                    height: 70, // Tamaño de las imágenes pequeñas
                  ),
                  SizedBox(width: 10), // Espacio entre las imágenes
                  Image.asset(
                    'assets/logos/RINCONES MÁGICOS imagen(2)-07-04.png',
                    height: 70,
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Indicador de carga
              SpinKitDualRing(
                color: Colors.teal,
                size: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
  }

