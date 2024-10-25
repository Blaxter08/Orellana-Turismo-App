import 'package:cloud_firestore/cloud_firestore.dart';

class TurismoComunitario {
  String id; // ID del registro
  String nombre; // Nombre de la cooperativa o servicio
  String tipoServicio; // Tipo de servicio (taxi, transporte interprovincial, fluvial, aéreo)
  String direccion; // Dirección de la base u oficina
  List<String> telefonos; // Lista de números telefónicos
  String sitioWeb; // URL del sitio web
  String correo; // Correo electrónico de contacto
  Map<String, String> redesSociales; // Redes sociales (clave: nombre, valor: URL)
  List<double> coordenadas; // Coordenadas de ubicación (latitud y longitud)
  String logo; // URL del logo de la cooperativa o servicio
  List<String> imagenes; // Imágenes adicionales del servicio
  String horario; // Horario de atención
  List<String> rutasDisponibles; // Lista de rutas o destinos disponibles
  DocumentSnapshot? documentSnapshot; // Campo para almacenar el DocumentSnapshot

  TurismoComunitario({
    required this.id,
    required this.nombre,
    required this.tipoServicio,
    required this.direccion,
    required this.telefonos,
    required this.sitioWeb,
    required this.correo,
    required this.redesSociales,
    required this.coordenadas,
    required this.logo,
    required this.imagenes,
    required this.horario,
    required this.rutasDisponibles,
    this.documentSnapshot, // Inicializamos el snapshot como opcional
  });

  // Convertir datos a JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'tipoServicio': tipoServicio,
      'direccion': direccion,
      'telefonos': telefonos,
      'sitioWeb': sitioWeb,
      'correo': correo,
      'redesSociales': redesSociales,
      'coordenadas': coordenadas,
      'logo': logo,
      'imagenes': imagenes,
      'horario': horario,
      'rutasDisponibles': rutasDisponibles,
    };
  }

  // Crear una instancia desde JSON
  factory TurismoComunitario.fromJson(Map<String, dynamic> json, String id, [DocumentSnapshot? snapshot]) {
    return TurismoComunitario(
      id: id,
      nombre: json['nombre'] ?? '',
      tipoServicio: json['tipoServicio'] ?? '',
      direccion: json['direccion'] ?? '',
      telefonos: List<String>.from(json['telefonos'] ?? []),
      sitioWeb: json['sitioWeb'] ?? '',
      correo: json['correo'] ?? '',
      redesSociales: Map<String, String>.from(json['redesSociales'] ?? {}),
      coordenadas: List<double>.from((json['coordenadas'] as List).map((e) => e.toDouble())),
      logo: json['logo'] ?? '',
      imagenes: List<String>.from(json['imagenes'] ?? []),
      horario: json['horario'] ?? '',
      rutasDisponibles: List<String>.from(json['rutasDisponibles'] ?? []),
      documentSnapshot: snapshot, // Asignamos el snapshot si está presente
    );
  }
}
