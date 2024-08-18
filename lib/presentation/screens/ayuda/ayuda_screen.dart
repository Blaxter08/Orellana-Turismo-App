import 'package:flutter/material.dart';
import 'package:turismo_app/config/theme/appbar_theme.dart';

class AyudaScreen extends StatelessWidget {
  const AyudaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(
        // backgroundColor: CustomAppBarColor.appBarColor, // Color de fondo del AppBar
        elevation: 0, // Elevación del AppBar
        title: Text('Ayuda',
          style: TextStyle(
            fontSize: 20, // Tamaño de fuente del título
            fontWeight: FontWeight.bold,
            // color: Colors.white// Peso de fuente del título
          ),
        ),
        centerTitle: true, // Centrar el título del AppBar
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Acción para el icono de la derecha
        //     },
        //     icon: Icon(Icons.search), // Icono de búsqueda
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       // Acción para el icono de la derecha
        //     },
        //     icon: Icon(Icons.notifications), // Icono de notificaciones
        //   ),
        // ],
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
          fit: BoxFit.cover,
          height: 100,
          width: 100,
              'assets/supp.png'),
            SizedBox(height: 20,),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 30,),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey, // Color de fondo gris
                  child: Icon(
                    Icons.phone, // Icono que deseas mostrar
                    color: Colors.white, // Color del icono
                    size: 30, // Tamaño del icono
                  ),
                ),
                SizedBox(width: 30,),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.email, // Icono que deseas mostrar
                    color: Colors.white, // Color del icono
                    size: 30, // Tamaño del icono
                  ),

                ),
                SizedBox(width: 30,),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.travel_explore, // Icono que deseas mostrar
                    color: Colors.white, // Color del icono
                    size: 30, // Tamaño del icono
                  ),
                ),
                SizedBox(width: 30,),
              ],
            ),
          SizedBox(height: 20,),
          Text(
              textAlign: TextAlign.center,
              'Comparte tus comentarios, ideas o inquietudes. Un representante se pondrá en contacto contigo en menos de 24 horas.')
        ],
      ),
    );
  }
}
