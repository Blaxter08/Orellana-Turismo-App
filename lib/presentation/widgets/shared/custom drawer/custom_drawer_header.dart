import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  final String displayName;
  final String email;
  final String photoURL;

  const CustomDrawerHeader({
    Key? key,
    required this.displayName,
    required this.email,
    required this.photoURL,
  }) : super(key: key);

  // Estado de carga
  factory CustomDrawerHeader.loading() {
    return CustomDrawerHeader(
      displayName: 'Cargando...',
      email: '',
      photoURL: '',
    );
  }

  // Estado de error
  factory CustomDrawerHeader.error() {
    return CustomDrawerHeader(
      displayName: 'Error al cargar',
      email: '',
      photoURL: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade500, Colors.teal.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero, // Eliminamos cualquier margen o padding innecesario
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              backgroundImage: photoURL.isNotEmpty
                  ? NetworkImage(photoURL)
                  : AssetImage('assets/usuario.png') as ImageProvider,
            ),
            SizedBox(height: 12),
            Text(
              displayName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 6),
            Text(
              email,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
