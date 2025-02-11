class AlojamientoTuristico {
  String? id; // Agregamos el campo id, opcional
  String nombre;
  double puntuacion;
  String direccion;
  List<String> telefonosMoviles;
  List<String> telefonosConvencionales;
  String sitioWeb;
  List<String> correos;
  Map<String, String> redesSociales;
  List<double> coordenadas;
  String logo;
  List<String> imagenes;
  String categoriaPrincipal;
  String subCategoria;
  String horaApertura;
  String horaCierre;

  AlojamientoTuristico({
    this.id, // El id es opcional al crear
    required this.nombre,
    required this.puntuacion,
    required this.direccion,
    required this.telefonosMoviles,
    required this.telefonosConvencionales,
    required this.sitioWeb,
    required this.correos,
    required this.redesSociales,
    required this.coordenadas,
    required this.logo,
    required this.imagenes,
    required this.categoriaPrincipal,
    required this.subCategoria,
    required this.horaApertura,
    required this.horaCierre,
  });

  // Convertir a JSON para Firestore
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'puntuacion': puntuacion,
      'direccion': direccion,
      'telefonosMoviles': telefonosMoviles,
      'telefonosConvencionales': telefonosConvencionales,
      'sitioWeb': sitioWeb,
      'correos': correos,
      'redesSociales': redesSociales,
      'coordenadas': coordenadas,
      'logo': logo,
      'imagenes': imagenes,
      'categoriaPrincipal': categoriaPrincipal,
      'subCategoria': subCategoria,
      'horaApertura': horaApertura,
      'horaCierre': horaCierre,
    };
  }

  // Crear una instancia de AlojamientoTuristico desde un JSON
  factory AlojamientoTuristico.fromJson(Map<String, dynamic> json, String id) {
    return AlojamientoTuristico(
      id: id,
      nombre: json['nombre'] ?? '',
      puntuacion: (json['puntuacion'] is int) // Convertir int a double si es necesario
          ? (json['puntuacion'] as int).toDouble()
          : (json['puntuacion'] ?? 0.0),
      direccion: json['direccion'] ?? '',
      telefonosMoviles: List<String>.from(json['telefonosMoviles'] ?? []),
      telefonosConvencionales: List<String>.from(json['telefonosConvencionales'] ?? []),
      sitioWeb: json['sitioWeb'] ?? '',
      correos: List<String>.from(json['correos'] ?? []),
      redesSociales: Map<String, String>.from(json['redesSociales'] ?? {}),
      coordenadas: (json['coordenadas'] as List).map((e) => (e is int ? e.toDouble() : e as double)).toList(),
      logo: json['logo'] ?? '',
      imagenes: List<String>.from(json['imagenes'] ?? []),
      categoriaPrincipal: json['categoriaPrincipal'] ?? '',
      subCategoria: json['subCategoria'] ?? '',
      horaApertura: json['horaApertura'] ?? '',
      horaCierre: json['horaCierre'] ?? '',
    );
  }
}
