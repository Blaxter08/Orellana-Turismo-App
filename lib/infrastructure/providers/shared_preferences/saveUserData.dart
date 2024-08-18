import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Función para guardar los datos de inicio de sesión del usuario en SharedPreferences
// Función para guardar el UID del usuario en SharedPreferences
Future<void> saveUserUid(String uid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('uid', uid);
}

// Función para eliminar las preferencias del usuario al cerrar sesión
Future<void> clearUserPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('uid'); // Elimina la clave 'uid'
}