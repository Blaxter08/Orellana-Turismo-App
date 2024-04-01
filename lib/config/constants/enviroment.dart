import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment{
  static String SitiosKey =dotenv.env['Sitios_key'] ?? 'No hay APIKEY';
}