class TourCorto {
  final String id;
  final String nombre;
  final String tiempo;
  final String detalle;
  final String costo;
  final List<Contacto> contactos;
  final String logo;
  final List<String> imagenes;

  TourCorto({
    required this.id,
    required this.nombre,
    required this.tiempo,
    required this.detalle,
    required this.costo,
    required this.contactos,
    required this.logo,
    required this.imagenes,
  });

  // Convertir el modelo a Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'tiempo': tiempo,
      'detalle': detalle,
      'costo': costo,
      'contactos': contactos.map((c) => c.toMap()).toList(),
      'logo': logo,
      'imagenes': imagenes,
    };
  }

  // Crear una instancia del modelo desde un Map
  factory TourCorto.fromMap(Map<String, dynamic> map, String id) {
    return TourCorto(
      id: id,
      nombre: map['nombre'] ?? '',
      tiempo: map['tiempo'] ?? '',
      detalle: map['detalle'] ?? '',
      costo: map['costo'] ?? '',
      contactos: List<Contacto>.from(
        (map['contactos'] ?? []).map((c) => Contacto.fromMap(c)),
      ),
      logo: map['logo'] ?? '',
      imagenes: List<String>.from(map['imagenes'] ?? []),
    );
  }
}

class Contacto {
  final String nombreAgencia;
  final String telefono;

  Contacto({required this.nombreAgencia, required this.telefono});

  Map<String, dynamic> toMap() {
    return {
      'nombreAgencia': nombreAgencia,
      'telefono': telefono,
    };
  }

  factory Contacto.fromMap(Map<String, dynamic> map) {
    return Contacto(
      nombreAgencia: map['nombreAgencia'] ?? '',
      telefono: map['telefono'] ?? '',
    );
  }
}
