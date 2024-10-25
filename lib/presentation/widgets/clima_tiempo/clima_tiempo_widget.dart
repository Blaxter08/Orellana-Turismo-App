import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherWidget extends StatelessWidget {
  final dynamic weatherData;

  const WeatherWidget({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (weatherData == null) {
      return Center(child: Text('No se pudo obtener el clima.'));
    }

    // Extracción de datos
    double? temp = weatherData['main']?['temp'];
    String city = weatherData['name'] ?? 'Desconocido';
    String weatherCondition = weatherData['weather']?[0]['main'] ?? 'Clear';
    String description = _getWeatherDescription(weatherCondition);

    // Validación de temperatura
    if (temp == null || temp.isNaN || temp.isInfinite) {
      temp = 0.0;
    }

    // Seleccionar ícono y color según la condición climática
    IconData weatherIcon = _getWeatherIcon(weatherCondition);
    Color backgroundColor = _getBackgroundColor(weatherCondition);

    // Diseño visual mejorado
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity, // Ocupa todo el ancho
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.85), // Fondo semitransparente
          borderRadius: BorderRadius.circular(15), // Bordes redondeados
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                FaIcon(
                  weatherIcon,
                  size: 25,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '${temp.toStringAsFixed(1)}°C',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para obtener íconos de clima basados en las condiciones climáticas
  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return FontAwesomeIcons.sun;
      case 'clouds':
        return FontAwesomeIcons.cloudBolt;
      case 'rain':
        return FontAwesomeIcons.cloudRain;
      case 'snow':
        return FontAwesomeIcons.snowflake;
      default:
        return FontAwesomeIcons.cloudSun; // Icono por defecto
    }
  }

  // Método para obtener el color de fondo basado en las condiciones climáticas
  Color _getBackgroundColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Colors.orangeAccent; // Despejado
      case 'clouds':
        return Colors.blueGrey.shade500; // Nublado
      case 'rain':
        return Colors.blueGrey.shade600; // Lluvia
      case 'snow':
        return Colors.lightBlueAccent; // Nieve
      default:
        return Colors.blueAccent.withOpacity(0.7); // Clima por defecto
    }
  }

  // Método para obtener la descripción del clima actual
  String _getWeatherDescription(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'Se prevé sol';
      case 'clouds':
        return 'Cielo nublado';
      case 'rain':
        return 'Se esperan lluvias';
      case 'snow':
        return 'Nevadas en curso';
      default:
        return 'Clima variable';
    }
  }
}
