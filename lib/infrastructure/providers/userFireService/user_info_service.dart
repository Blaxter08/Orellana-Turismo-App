import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Obtener UID del usuario (con soporte para SharedPreferences)
  Future<String?> getUserUid() async {
    User? user = _auth.currentUser;
    if (user == null) return null;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid') ?? user.uid;

    // Guardar UID en SharedPreferences si aún no está guardado
    await prefs.setString('uid', uid);
    return uid;
  }

  // Obtener datos del usuario desde Firestore
  Future<DocumentSnapshot?> getUserData() async {
    String? uid = await getUserUid();
    if (uid == null) return null;

    return _firestore.collection('users').doc(uid).get();
  }

  // Actualizar datos del usuario
  Future<void> updateUserData(Map<String, dynamic> data) async {
    String? uid = await getUserUid();
    if (uid == null) throw Exception('El usuario no está autenticado.');

    await _firestore.collection('users').doc(uid).update(data);
  }
  // Método para cerrar sesión
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }
}
