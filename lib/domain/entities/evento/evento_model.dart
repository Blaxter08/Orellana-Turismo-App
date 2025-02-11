import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id; // ID único del evento
  final String title; // Título del evento
  final String description; // Descripción detallada del evento
  final DateTime startDate; // Fecha y hora de inicio
  final DateTime endDate; // Fecha y hora de finalización
  final String location; // Lugar del evento
  final String imageUrl; // URL o ruta local de la imagen representativa
  final String organizer; // Nombre del organizador
  final String contactInfo; // Información de contacto del organizador
  final List<String> tags; // Etiquetas o categorías (por ejemplo: "Cultura", "Música")
  final double? ticketPrice; // Precio de entrada, si aplica
  final String? ticketUrl; // Enlace para comprar entradas
  final bool isFree; // Indica si el evento es gratuito
  final int maxAttendees; // Capacidad máxima de asistentes
  final int currentAttendees; // Número actual de inscritos o asistentes
  final bool isHighlighted; // Indica si el evento es destacado
  final Map<String, dynamic> additionalInfo; // Información adicional personalizada
  final bool isActive; // Indica si el evento está activo

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.imageUrl,
    required this.organizer,
    required this.contactInfo,
    required this.tags,
    this.ticketPrice,
    this.ticketUrl,
    required this.isFree,
    required this.maxAttendees,
    required this.currentAttendees,
    required this.isHighlighted,
    required this.additionalInfo,
    this.isActive = true, // Por defecto, el evento está activo
  });

  // Método para convertir un evento a Map (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'location': location,
      'imageUrl': imageUrl,
      'organizer': organizer,
      'contactInfo': contactInfo,
      'tags': tags,
      'ticketPrice': ticketPrice,
      'ticketUrl': ticketUrl,
      'isFree': isFree,
      'maxAttendees': maxAttendees,
      'currentAttendees': currentAttendees,
      'isHighlighted': isHighlighted,
      'additionalInfo': additionalInfo,
      'isActive': isActive,
    };
  }

  // Método para crear un evento a partir de un Map (al leer de Firestore)
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      organizer: map['organizer'] ?? '',
      contactInfo: map['contactInfo'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      ticketPrice: (map['ticketPrice'] as num?)?.toDouble(),
      ticketUrl: map['ticketUrl'],
      isFree: map['isFree'] ?? false,
      maxAttendees: map['maxAttendees'] ?? 0,
      currentAttendees: map['currentAttendees'] ?? 0,
      isHighlighted: map['isHighlighted'] ?? false,
      additionalInfo: Map<String, dynamic>.from(map['additionalInfo'] ?? {}),
      isActive: map['isActive'] ?? true,
    );
  }

  // Método copyWith para actualizar propiedades específicas
  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? location,
    String? imageUrl,
    String? organizer,
    String? contactInfo,
    List<String>? tags,
    double? ticketPrice,
    String? ticketUrl,
    bool? isFree,
    int? maxAttendees,
    int? currentAttendees,
    bool? isHighlighted,
    Map<String, dynamic>? additionalInfo,
    bool? isActive,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      organizer: organizer ?? this.organizer,
      contactInfo: contactInfo ?? this.contactInfo,
      tags: tags ?? this.tags,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      ticketUrl: ticketUrl ?? this.ticketUrl,
      isFree: isFree ?? this.isFree,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      currentAttendees: currentAttendees ?? this.currentAttendees,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      isActive: isActive ?? this.isActive,
    );
  }
}
