import 'package:turismo_app/domain/entities/entities.dart';

class Evento {
  final String name;
  final String description;
  final List<String> activities;
  final String img;
  // final DateTime createTime;
  // final DateTime updateTime;

  Evento({
    required this.name,
    required this.description,
    required this.activities,
    required this.img,
    // required this.createTime,
    // required this.updateTime,
  });

  factory Evento.fromFirestore(Map<String, dynamic> data) {
    List<dynamic> activities = data['activities'] ?? []; // Utiliza el campo correcto para las actividades
    return Evento(
      name: data['name'] ?? '',
      img: data['img'] ?? '',
      description: data['description'] ?? '',
      activities: activities.map((e) => e.toString()).toList(),
    );
  }
}
