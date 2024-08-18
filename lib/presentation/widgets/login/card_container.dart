import 'package:flutter/material.dart';

class card_Container extends StatelessWidget {
  final Widget child;

  const card_Container({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        //height: 300,
        padding: EdgeInsets.all(20),
        decoration: _card_Container(
        ),
        child: this.child,
      ),
    );
  }
  BoxDecoration _card_Container() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset: Offset(0,5),
        )
      ]

  );
}

