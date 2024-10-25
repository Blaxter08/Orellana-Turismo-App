import 'package:cloud_firestore/cloud_firestore.dart';

class AtractivoTuristico {
  String nombre;
  String direccion;
  String descripcion;
  String quehacer;
  String logo;
  List<String> actividades;
  List<double> coordenadas;
  String telefono;
  String correo;
  List<String> imagenes;
  String categoriaPrincipal;
  String subCategoria;
  String comoLlegar;
  DocumentSnapshot? documentSnapshot; // Agregamos el DocumentSnapshot como opcional

  AtractivoTuristico({
    required this.nombre,
    required this.direccion,
    required this.descripcion,
    required this.quehacer,
    required this.logo,
    required this.actividades,
    required this.coordenadas,
    required this.telefono,
    required this.correo,
    required this.imagenes,
    required this.categoriaPrincipal,
    required this.subCategoria,
    required this.comoLlegar,
    this.documentSnapshot, // Inicializamos el snapshot como opcional
  });

  // Convertir datos a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'direccion': direccion,
      'descripcion': descripcion,
      'quehacer': quehacer,
      'logo': logo,
      'actividades': actividades,
      'coordenadas': coordenadas,
      'telefono': telefono,
      'correo': correo,
      'imagenes': imagenes,
      'categoriaPrincipal': categoriaPrincipal,
      'subCategoria': subCategoria,
      'comoLlegar': comoLlegar,
    };
  }

  // Crear una instancia de AtractivoTuristico desde JSON
  factory AtractivoTuristico.fromJson(Map<String, dynamic> json, [DocumentSnapshot? snapshot]) {
    return AtractivoTuristico(
      nombre: json['nombre'],
      direccion: json['direccion'],
      descripcion: json['descripcion'],
      quehacer: json['quehacer'],
      logo: json['logo'],
      actividades: List<String>.from(json['actividades']),
      coordenadas: List<double>.from(json['coordenadas'].map((e) => e.toDouble())),
      telefono: json['telefono'],
      correo: json['correo'],
      imagenes: List<String>.from(json['imagenes']),
      categoriaPrincipal: json['categoriaPrincipal'],
      subCategoria: json['subCategoria'],
      comoLlegar: json['comoLlegar'],
      documentSnapshot: snapshot, // Asignamos el snapshot si está presente
    );
  }
}
