import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration loginInpuDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }){
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.green
          )
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 2,
          )
      ),
      hintText: hintText,
      labelText:  labelText,
      labelStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold
      ),
      prefixIcon: prefixIcon != null ?
      Icon(
        prefixIcon,
        color: Colors.green,
      ): null,
    );
  }
}