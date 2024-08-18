import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      currentIndex: currentIndex,
      elevation: 0,
      onTap: onTap,
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
    );
  }
}
