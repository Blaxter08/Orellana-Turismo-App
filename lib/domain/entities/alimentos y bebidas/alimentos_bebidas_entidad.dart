import 'package:cloud_firestore/cloud_firestore.dart';

class AlimentosYBebidas {
  String? id; // Campo id opcional
  String nombre;
  String categoriaPrincipal;
  String subCategoria;
  String direccion;
  List<String> telefonosMoviles; // Lista de teléfonos móviles (pueden haber uno o más)
  String logo; // URL del logo
  List<String> imagenes; // Lista de URLs de imágenes
  List<double> coordenadas; // Coordenadas (latitud y longitud)
  String horaApertura;
  String horaCierre;
  String sitioWeb;
  String correo;
  Map<String, String> redesSociales; // Mapa para manejar las redes sociales (nombre de red y URL)

  // Agregamos el snapshot como campo privado
  final DocumentSnapshot? _documentSnapshot;

  AlimentosYBebidas({
    this.id, // id es opcional al crear
    required this.nombre,
    required this.categoriaPrincipal,
    required this.subCategoria,
    required this.direccion,
    required this.telefonosMoviles,
    required this.logo,
    required this.imagenes,
    required this.coordenadas,
    required this.horaApertura,
    required this.horaCierre,
    required this.sitioWeb,
    required this.correo,
    required this.redesSociales,
    DocumentSnapshot? documentSnapshot,
  }) : _documentSnapshot = documentSnapshot;

  // Getter para acceder al snapshot
  DocumentSnapshot? get documentSnapshot => _documentSnapshot;

  // Convertir a JSON para almacenar en Firestore
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'categoriaPrincipal': categoriaPrincipal,
      'subCategoria': subCategoria,
      'direccion': direccion,
      'telefonosMoviles': telefonosMoviles,
      'logo': logo,
      'imagenes': imagenes,
      'coordenadas': coordenadas,
      'horaApertura': horaApertura,
      'horaCierre': horaCierre,
      'sitioWeb': sitioWeb,
      'correo': correo,
      'redesSociales': redesSociales,
    };
  }

  // Crear una instancia de AlimentosYBebidas desde un JSON
  factory AlimentosYBebidas.fromJson(Map<String, dynamic> json, String id, {DocumentSnapshot? documentSnapshot}) {
    return AlimentosYBebidas(
      id: id,
      nombre: json['nombre'] ?? '',
      categoriaPrincipal: json['categoriaPrincipal'] ?? '',
      subCategoria: json['subCategoria'] ?? '',
      direccion: json['direccion'] ?? '',
      telefonosMoviles: List<String>.from(json['telefonosMoviles'] ?? []),
      logo: json['logo'] ?? '',
      imagenes: List<String>.from(json['imagenes'] ?? []),
      coordenadas: List<double>.from((json['coordenadas'] as List).map((e) => e is int ? e.toDouble() : e)),
      horaApertura: json['horaApertura'] ?? '',
      horaCierre: json['horaCierre'] ?? '',
      sitioWeb: json['sitioWeb'] ?? '',
      correo: json['correo'] ?? '',
      redesSociales: Map<String, String>.from(json['redesSociales'] ?? {}),
      documentSnapshot: documentSnapshot,
    );
  }
}
