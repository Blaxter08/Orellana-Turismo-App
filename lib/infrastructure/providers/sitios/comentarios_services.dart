import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/entities.dart';

class ComentarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> agregarComentario(Comentario comentario) async {
    try {
      await _firestore.collection('comentarios').add({
        'fecha': comentario.fecha,
        'idSitio': comentario.idSitio,
        'idUsuario': comentario.idUsuario,
        'comentario': comentario.comentario,
      });
    } catch (e) {
      throw Exception('Error al agregar el comentario: $e');
    }
  }

  Stream<List<Comentario>> getComentariosPorSitio(String sitioId) {
    return _firestore
        .collection('comentarios')
        .where('idSitio', isEqualTo: sitioId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Comentario.fromMap(doc.data())).toList());
  }
}

// class ComentariosService {
//   static Stream<List<Comentario>> getComentariosStream(String sitioId) {
//     return FirebaseFirestore.instance
//         .collection('comentarios')
//         .where('idSitio', isEqualTo: sitioId)
//         .snapshots()
//         .map((snapshot) => snapshot.docs.map((doc) => Comentario.fromMap(doc.data())).toList());
//   }
// }
