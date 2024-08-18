import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  final VoidCallback onSplashFinished;

  const SplashView({Key? key, required this.onSplashFinished}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Llamamos a la función que verifica si el usuario ya está logueado
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    // Esperamos un breve período para simular la carga
    await Future.delayed(Duration(seconds: 2));

    // Verificamos si el UID del usuario está guardado en SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('uid');

    // Si el UID está presente, significa que el usuario ya está logueado
    if (uid != null) {
      // Navegamos directamente a la pantalla de inicio
      print(uid);
      context.go('/home');
    } else {
      // Si el UID no está presente, ejecutamos la función proporcionada para finalizar la pantalla de Splash
      widget.onSplashFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Aquí puedes personalizar la apariencia de tu pantalla de Splash
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/COCA-VIVELO.png'),
              SizedBox(height: 10,),
              LinearProgressIndicator(color: Colors.green,),
              // CircularProgressIndicator(color: Colors.green,), // Puedes reemplazar esto con tu propio indicador de carga
              SizedBox(height: 20), // Puedes personalizar este texto según tus necesidades
            ],
          ),
        ),
      ),
    );
  }
}
