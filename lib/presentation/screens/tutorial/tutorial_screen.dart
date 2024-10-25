import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          _buildPage(
            context,
            'assets/tutorial1.png',
            '¡Bienvenido a Coca-Vívelo!',
            'Explora, disfruta y descubre lo mejor de Orellana con nuestra app.',
          ),
          _buildPage(
            context,
            'assets/tutorial2.png',
            'Explora Orellana',
            'Descripción del segundo consejo',
          ),
          _buildPage(
            context,
            'assets/tutorial3.png',
            'Encuentra lo mejor',
            'Descripción del tercer consejo',
            isLastPage: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String image, String title, String description, {bool isLastPage = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300),
        SizedBox(height: 20),
        Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(description, textAlign: TextAlign.center),
        ),
        SizedBox(height: 50),
        if (isLastPage)
          ElevatedButton(
            onPressed: () async {
              // Guardar que el usuario ya vio el tutorial
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('seenTutorial', true);

              // Ir al login o home
              context.go('/login'); // o '/home' si el usuario está logeado
            },
            child: Text('Empezar'),
          ),
      ],
    );
  }
}
