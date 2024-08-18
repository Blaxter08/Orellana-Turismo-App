import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login_Background extends StatelessWidget {
  final Widget child;

  const Login_Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red ,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _greenBox(),
          _headerIcon(),
          this.child,


        ],
      ),
    );
  }
}

class _headerIcon extends StatelessWidget {
  const _headerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 45),
        child: Image.asset(
            'assets/COCA-VIVELO.png',
            width: 80,
            height: 100,

        )

      ),
    );
  }
}




class _greenBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: size.width,
      decoration: _greenBackground(),
      child: Stack(
        children: [
          // Positioned(child: _form_dog(),top: 150, left: 40,),
          // Positioned(child: _form_cat(),top: 60, right: 30,),
          // Positioned(child: _form_bird(),top: 30, left: -10,),
          // Positioned(child: _form_hamster(),bottom: 10, right: 90,)
        ],
      ),
    );
  }
  BoxDecoration _greenBackground() =>BoxDecoration(
      gradient: LinearGradient(
          colors: [
            Color.fromRGBO(40, 224, 103, 0.5),
            Color.fromRGBO(40, 224, 103, 0.7),
            Color.fromRGBO(40, 223, 113, 1 )
          ]
      )
  );
}


class _form_dog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Image(
          image: AssetImage('assets/perro.png'),
          color: Color.fromRGBO(255, 255, 255, 0.2)

      ),
    );
  }
}
class _form_cat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Image(
          image: AssetImage('assets/gato.png'),
          color: Color.fromRGBO(255, 255, 255, 0.2)

      ),
    );
  }
}
class _form_bird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Image(
          image: AssetImage('assets/ave.png'),
          color: Color.fromRGBO(255, 255, 255, 0.2)

      ),
    );
  }
}
class _form_hamster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Image(
          image: AssetImage('assets/hamster.png'),
          color: Color.fromRGBO(255, 255, 255, 0.2)

      ),
    );
  }
}