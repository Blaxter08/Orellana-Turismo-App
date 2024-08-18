// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class AuthProviderG {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<User?> signInWithGoogle() async {
//     try {
//       // Inicia sesión con Google
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//         final UserCredential authResult = await _auth.signInWithCredential(credential);
//         final User? user = authResult.user;
//
//         // Registra al usuario en Firestore si se autentica correctamente
//         if (user != null) {
//           await registerUserInFirestore(user);
//         }
//
//         return user;
//       } else {
//         // El usuario canceló el inicio de sesión
//         print('Google sign in canceled.');
//         return null;
//       }
//     } catch (error) {
//       // Manejar errores de inicio de sesión con Google
//       print('Error signing in with Google: $error');
//       return null;
//     }
//   }
//
//   Future<void> registerUserInFirestore(User user) async {
//     try {
//       // Agrega los datos del usuario a Firestore
//       await _firestore.collection('users').doc(user.uid).set({
//         'displayName': user.displayName,
//         'email': user.email,
//         // Agrega cualquier otro dato que desees guardar del usuario
//       });
//     } catch (error) {
//       // Manejar errores al registrar el usuario en Firestore
//       print('Error registering user in Firestore: $error');
//     }
//   }
// }
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Cierra sesión en Google para asegurarse de que se muestre la ventana de inicio de sesión la próxima vez
      await _googleSignIn.signOut();

      // Inicia sesión con Google
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      // Crea una credencial de autenticación con Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Inicia sesión con Firebase
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
