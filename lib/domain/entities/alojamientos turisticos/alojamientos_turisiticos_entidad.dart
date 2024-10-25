import 'package:cloud_firestore/cloud_firestore.dart';

class AlojamientoTuristico {
  String id;
  String nombre;
  String direccion;
  String logo;
  List<String> telefonosMoviles;
  String telefonoConvencional;
  String sitioWeb;
  String correo;
  Map<String, String> redesSociales;
  List<double> coordenadas;
  List<String> imagenes;
  String categoriaPrincipal;
  String subCategoria;
  DocumentSnapshot? documentSnapshot; // Campo opcional para DocumentSnapshot

  AlojamientoTuristico({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.logo,
    required this.telefonosMoviles,
    required this.telefonoConvencional,
    required this.sitioWeb,
    required this.correo,
    required this.redesSociales,
    required this.coordenadas,
    required this.imagenes,
    required this.categoriaPrincipal,
    required this.subCategoria,
    this.documentSnapshot, // Inicializar el snapshot como opcional
  });

  // Convertir datos a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'direccion': direccion,
      'logo': logo,
      'telefonosMoviles': telefonosMoviles,
      'telefonoConvencional': telefonoConvencional,
      'sitioWeb': sitioWeb,
      'correo': correo,
      'redesSociales': redesSociales,
      'coordenadas': coordenadas,
      'imagenes': imagenes,
      'categoriaPrincipal': categoriaPrincipal,
      'subCategoria': subCategoria,
    };
  }

  // Crear una instancia de AlojamientoTuristico desde JSON
  factory AlojamientoTuristico.fromJson(Map<String, dynamic> json, String id, [DocumentSnapshot? snapshot]) {
    return AlojamientoTuristico(
      id: id,
      nombre: json['nombre'] ?? '',
      direccion: json['direccion'] ?? '',
      logo: json['logo'] ?? '',
      telefonosMoviles: List<String>.from(json['telefonosMoviles'] ?? []),
      telefonoConvencional: json['telefonoConvencional'] ?? '',
      sitioWeb: json['sitioWeb'] ?? '',
      correo: json['correo'] ?? '',
      redesSociales: Map<String, String>.from(json['redesSociales'] ?? {}),
      coordenadas: List<double>.from((json['coordenadas'] as List).map((e) => e is int ? e.toDouble() : e)),
      imagenes: List<String>.from(json['imagenes'] ?? []),
      categoriaPrincipal: json['categoriaPrincipal'] ?? '',
      subCategoria: json['subCategoria'] ?? '',
      documentSnapshot: snapshot, // Asignar el snapshot si está presente
    );
  }
}
