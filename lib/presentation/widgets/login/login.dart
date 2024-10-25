import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _GreenBox(),
          _HeaderLogos(), // Mostrar ambos logos
          this.child,
        ],
      ),
    );
  }
}

class _HeaderLogos extends StatelessWidget {
  const _HeaderLogos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Espacio entre los logos
            Image.asset(
              'assets/logos/coca_vivelo.png',
              // Reemplaza con la ruta de tu segundo logo
              width: 150,
              height: 150,
            ),
            SizedBox(width: 20),
            // Image.asset(
            //   'assets/logos/coca_vivelo.png',
            //   width: 150,
            //   height: 150,
            // ),
          ],
        ),
      ),
    );
  }
}

class _GreenBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: size.width,
      // decoration: _greenBackground(),
      child: Opacity(
        opacity: 0.4,
        child: Image.asset('assets/images/el_coca_portada1.jpg',
          fit: BoxFit.cover,
          
        ),
      ),
    );
  }

  BoxDecoration _greenBackground() => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(40, 224, 103, 0.5),
            Color.fromRGBO(40, 224, 103, 0.7),
            Color.fromRGBO(40, 223, 113, 1),
          ],
        ),
      );
}
