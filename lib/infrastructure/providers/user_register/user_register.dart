import 'package:cloud_firestore/cloud_firestore.dart';

class UserRegistration {
  static Future<void> registerUser({
    required String username,
    required String email,
    required String phoneNumber,
    required String address,
    required String password,
  }) async {
    try {
      // Guardar los datos del usuario en Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'displayName': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'password': password,
        'photoURL': '',
        // Opcional: puedes agregar más campos aquí según sea necesario
      });

      print('Usuario registrado exitosamente');
    } catch (error) {
      print('Error al registrar usuario: $error');
      throw error; // Opcional: puedes manejar el error de otra manera según sea necesario
    }
  }
}
