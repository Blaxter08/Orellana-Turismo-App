import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final categoriasProvider = StreamProvider.autoDispose<List<DocumentSnapshot>>((ref) {
  return FirebaseFirestore.instance.collection('categorias').snapshots().map((snapshot) {
    return snapshot.docs;
  });
});
