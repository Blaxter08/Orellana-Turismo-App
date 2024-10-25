import 'package:cloud_firestore/cloud_firestore.dart';

class Coordenadas {
  final double latitud;
  final double longitud;

  Coordenadas({required this.latitud, required this.longitud});

  Map<String, dynamic> toMap() {
    return {
      'latitud': latitud,
      'longitud': longitud,
    };
  }

  static Coordenadas fromMap(Map<String, dynamic> map) {
    return Coordenadas(
      latitud: (map['latitud'] as num?)?.toDouble() ?? 0.0,
      longitud: (map['longitud'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Servicio {
  final String nombre;
  final String descripcion;

  Servicio({required this.nombre, required this.descripcion});

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }

  static Servicio fromMap(Map<String, dynamic> map) {
    return Servicio(
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'] ?? '',
    );
  }
}

class Producto {
  final String nombre;
  final String descripcion;
  final double precio;

  Producto({required this.nombre, required this.descripcion, required this.precio});

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    };
  }

  static Producto fromMap(Map<String, dynamic> map) {
    return Producto(
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'] ?? '',
      precio: (map['precio'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Establishment {
  final String id;
  final String nombre;
  final String categoriaPrincipal;
  final String subCategoria;
  final String direccion;
  final Coordenadas coordenadas;
  final String telefono;
  final String email;
  final String logoUrl;
  final List<String> imagenes;
  final List<Servicio> servicios;
  final List<Producto> productos;
  final double puntuacion;
  final String horaApertura;  // Hora de apertura
  final String horaCierre;    // Hora de cierre
  final DocumentSnapshot documentSnapshot; // Para la paginación

  Establishment({
    required this.id,
    required this.nombre,
    required this.categoriaPrincipal,
    required this.subCategoria,
    required this.direccion,
    required this.coordenadas,
    required this.telefono,
    required this.email,
    required this.logoUrl,
    required this.imagenes,
    required this.servicios,
    required this.productos,
    required this.puntuacion,
    required this.horaApertura,
    required this.horaCierre,
    required this.documentSnapshot,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'categoriaPrincipal': categoriaPrincipal,
      'subCategoria': subCategoria,
      'direccion': direccion,
      'coordenadas': coordenadas.toMap(),
      'telefono': telefono,
      'email': email,
      'logoUrl': logoUrl,
      'imagenes': imagenes,
      'servicios': servicios.map((s) => s.toMap()).toList(),
      'productos': productos.map((p) => p.toMap()).toList(),
      'puntuacion': puntuacion,
      'horaApertura': horaApertura,  // Mapeamos la hora de apertura
      'horaCierre': horaCierre,      // Mapeamos la hora de cierre
    };
  }

  static Establishment fromMap(String id, Map<String, dynamic> data, DocumentSnapshot snapshot) {
    return Establishment(
      id: id,
      nombre: data['nombre'] ?? '',
      categoriaPrincipal: data['categoriaPrincipal'] ?? '',
      subCategoria: data['subCategoria'] ?? '',
      direccion: data['direccion'] ?? '',
      coordenadas: Coordenadas.fromMap(data['coordenadas'] as Map<String, dynamic>),
      telefono: data['telefono'] ?? '',
      email: data['email'] ?? '',
      logoUrl: data['logoUrl'] ?? '',
      imagenes: List<String>.from(data['imagenes'] as List<dynamic>? ?? []),
      servicios: List<Servicio>.from((data['servicios'] as List<dynamic>? ?? []).map((s) => Servicio.fromMap(s as Map<String, dynamic>))),
      productos: List<Producto>.from((data['productos'] as List<dynamic>? ?? []).map((p) => Producto.fromMap(p as Map<String, dynamic>))),
      puntuacion: (data['puntuacion'] as num?)?.toDouble() ?? 0.0,
      horaApertura: data['horaApertura'] ?? '',
      horaCierre: data['horaCierre'] ?? '',
      documentSnapshot: snapshot,
    );
}
}
