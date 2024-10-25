import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = FutureProvider<DocumentSnapshot?>((ref) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return null;
  }

  // Intentamos obtener el UID desde SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uid = prefs.getString('uid') ?? user.uid;

  // Guardamos el UID en SharedPreferences
  await prefs.setString('uid', uid);

  // Obtenemos los datos del usuario desde Firestore
  return FirebaseFirestore.instance.collection('users').doc(uid).get();
});
