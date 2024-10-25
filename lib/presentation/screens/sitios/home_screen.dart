import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turismo_app/presentation/screens/establecimientos/Establishments_detail_screen.dart';
import 'package:turismo_app/presentation/widgets/widgets.dart';
import '../../views/categories/categories_screen.dart';
import '../../views/favorites/favorite_screen.dart';
import '../../views/sitios/home_screen_view.dart';

import '../maps/maps_screen.dart'; // Asegúrate de importar tu nueva vista del mapa

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Lista de pantallas, ahora con la nueva pantalla de Mapa
  final List<Widget> _views = [
    HomeScreenView(),      // Pantalla principal
    CategoriesScreen(),    // Pantalla de categorías
    FavoriteScreen(),      // Pantalla de favoritos
    MapScreenA(),           // Pantalla del mapa
  ];

  // Método para cambiar el índice de la pestaña seleccionada
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal, // Color seleccionado teal para consistencia con el tema
        unselectedItemColor: Colors.grey, // Color para los ítems no seleccionados
        currentIndex: _currentIndex,
        elevation: 5, // Agregar un poco de sombra
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined), // Nuevo ícono para el mapa
            label: 'Mapa',
          ),
        ],
      ),
    );
  }
}
