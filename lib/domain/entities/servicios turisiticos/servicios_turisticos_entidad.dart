import 'package:cloud_firestore/cloud_firestore.dart';

class ServicioTuristico {
  String nombre;
  String direccion;
  List<String> telefonosMoviles;
  String telefonoConvencional;
  String sitioWeb;
  String correo;
  Map<String, String> redesSociales;
  List<double> coordenadas;
  String logo;
  List<String> imagenes;
  String categoriaPrincipal;
  String subCategoria;
  DocumentSnapshot? documentSnapshot; // Campo opcional para almacenar el DocumentSnapshot

  ServicioTuristico({
    required this.nombre,
    required this.direccion,
    required this.telefonosMoviles,
    required this.telefonoConvencional,
    required this.sitioWeb,
    required this.correo,
    required this.redesSociales,
    required this.coordenadas,
    required this.logo,
    required this.imagenes,
    required this.categoriaPrincipal,
    required this.subCategoria,
    this.documentSnapshot, // Se inicializa como opcional
  });

  // Convertir datos a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'direccion': direccion,
      'telefonosMoviles': telefonosMoviles,
      'telefonoConvencional': telefonoConvencional,
      'sitioWeb': sitioWeb,
      'correo': correo,
      'redesSociales': redesSociales,
      'coordenadas': coordenadas,
      'logo': logo,
      'imagenes': imagenes,
      'categoriaPrincipal': categoriaPrincipal,
      'subCategoria': subCategoria,
    };
  }

  // Crear una instancia de ServicioTuristico desde JSON
  factory ServicioTuristico.fromJson(Map<String, dynamic> json, [DocumentSnapshot? snapshot]) {
    return ServicioTuristico(
      nombre: json['nombre'],
      direccion: json['direccion'],
      telefonosMoviles: List<String>.from(json['telefonosMoviles']),
      telefonoConvencional: json['telefonoConvencional'],
      sitioWeb: json['sitioWeb'],
      correo: json['correo'],
      redesSociales: Map<String, String>.from(json['redesSociales']),
      coordenadas: List<double>.from(json['coordenadas'].map((e) => e.toDouble())),
      logo: json['logo'],
      imagenes: List<String>.from(json['imagenes']),
      categoriaPrincipal: json['categoriaPrincipal'],
      subCategoria: json['subCategoria'],
      documentSnapshot: snapshot, // Asignar el DocumentSnapshot si está presente
    );
  }
}
