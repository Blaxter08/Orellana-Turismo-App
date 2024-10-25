import 'package:cloud_firestore/cloud_firestore.dart';

class Comentario {
  final Timestamp fecha;
  final String idSitio;
  final String idUsuario;
  final String comentario;

  Comentario({
    required this.fecha,
    required this.idSitio,
    required this.idUsuario,
    required this.comentario,
  });

  factory Comentario.fromMap(Map<String, dynamic> map) {
    return Comentario(
      fecha: map['fecha'] ?? Timestamp.now(),
      idSitio: map['idSitio'] ?? '',
      idUsuario: map['idUsuario'] ?? '',
      comentario: map['comentario'] ?? '',
    );
  }
}
