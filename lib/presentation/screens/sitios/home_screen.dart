import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turismo_app/config/theme/appbar_theme.dart';
import 'package:turismo_app/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../views/categories/categories_screen.dart';
import '../../views/favorites/favorite_screen.dart';
import '../../views/sitios/home_screen_view.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _views = [
    Home_Screen_View(),
    CategoriesScreen(),
    FavoriteScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explora Orellana'),
        centerTitle: true,
        flexibleSpace: Icon(Icons.abc_outlined),
      ),
      drawer: CustomDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex,
        elevation: 0,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_outline_sharp),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
