import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static Future<Map<String, dynamic>?> getUserData(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userSnapshot.exists) {
      return userSnapshot.data();
    } else {
      return null;
    }
  }
}
