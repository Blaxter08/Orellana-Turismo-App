import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> getWeather(double lat, double lon) async {
  final apiKey = 'e7c13c2fec9ca1c2b0e9898351e3240d'; // Reemplaza con tu clave de OpenWeatherMap
  final url = 'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,hourly,alerts&units=metric&appid=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final weatherData = json.decode(response.body);
    print(weatherData);  // Procesa los datos como lo desees
  } else {
    print('Error al obtener los datos del clima');
  }
}
