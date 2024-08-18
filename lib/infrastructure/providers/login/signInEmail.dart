import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String?> validateCredentials(String email, String password) async {
    try {
      // Realizar una consulta a Firestore para buscar el usuario con el correo electrónico proporcionado
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      // Verificar si se encontró un usuario con el correo electrónico proporcionado
      if (querySnapshot.docs.isNotEmpty) {
        // Obtener el UID del usuario
        final userDoc = querySnapshot.docs.first;
        final uid = userDoc.id;
        print(uid);

        // Validar la contraseña
        final storedPassword = userDoc['password']; // Obtener la contraseña almacenada en Firestore
        // Comparar la contraseña almacenada con la contraseña proporcionada
        if (storedPassword == password) {
          print(password);
          // final UserCredential authResult = await _auth.signInWithCredential(credential);
          // final User? user = authResult.user;
          // Devolver el UID del usuario si las credenciales son válidas
          return uid;
        }
      }
      // Si no se encuentra un usuario con el correo electrónico proporcionado o la contraseña no coincide, devuelve nulo
      return null;
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir durante la validación
      print('Error validating credentials: $e');
      return null;
    }
  }
}
