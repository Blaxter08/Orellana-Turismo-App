
import 'package:turismo_app/infrastructure/models/sitiosdb/sitiios_stiosdbresponde.dart';

class SitiosDbResponse {
  final String name;
  final Fields fields;
  final DateTime createTime;
  final DateTime updateTime;

  SitiosDbResponse({
    required this.name,
    required this.fields,
    required this.createTime,
    required this.updateTime,
  });

  factory SitiosDbResponse.fromMap(Map<String, dynamic> json) => SitiosDbResponse(
    name: json["name"],
    fields: Fields.fromMap(json["fields"]),
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "fields": fields.toMap(),
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
  };
}
