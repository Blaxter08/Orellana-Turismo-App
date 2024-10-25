import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/entities.dart';

class ComentarioService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> agregarComentario(Comentario comentario) async {
    try {
      await _firestore.collection('comentarios').add({
        'fecha': comentario.fecha,
        'idEstablecimiento': comentario.idSitio,
        'idUsuario': comentario.idUsuario,
        'comentario': comentario.comentario,
      });
    } catch (e) {
      throw Exception('Error al agregar el comentario: $e');
    }
  }

  Stream<List<Comentario>> getComentariosPorEstablishment(String establishmentId) {
    return _firestore
        .collection('comentarios')
        .where('idEstablecimiento', isEqualTo: establishmentId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Comentario.fromMap(doc.data() as Map<String, dynamic>)).toList());
  }
}
