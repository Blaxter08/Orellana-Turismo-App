import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turismo_app/presentation/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final Widget childView;

  const HomeScreen({super.key, required this.childView});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Lista de Sitios'),
      // ),
      body: childView,
      bottomNavigationBar:  CustomBottomNavigation(),
    );
  }
}
