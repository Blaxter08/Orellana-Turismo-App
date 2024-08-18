import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjustesScreen extends StatefulWidget {
  @override
  _AjustesScreenState createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  String _selectedLanguage = ''; // Variable para almacenar el idioma seleccionado

  @override
  void initState() {
    _loadSelectedLanguage(); // Cargar el idioma seleccionado al iniciar la pantalla
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          ListTile(
            title: Text('Cambiar Idioma'),
            subtitle: Text(_selectedLanguage),
            onTap: () => _showLanguageDialog(context),
          ),
          ListTile(
            title: Text('Cambiar Tema'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.nightlight_round), // Icono de sol
                Switch(
                  value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light,
                  onChanged: (bool value) {
                    if (value) {
                      AdaptiveTheme.of(context).setLight();
                    } else {
                      AdaptiveTheme.of(context).setDark();
                    }
                  },
                ),
                Icon(Icons.wb_sunny), // Icono de luna
              ],
            ),
          ),
          // Resto de tu código...
        ],
      ),
    );
  }

  // Método para cargar el idioma seleccionado desde SharedPreferences
  _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('language') ?? 'en'; // Por defecto, inglés
    setState(() {
      _selectedLanguage = language;
    });
  }

  // Método para mostrar un diálogo con la lista de idiomas disponibles
  _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar Idioma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption(context, 'Español', 'es'),
              _languageOption(context, 'English', 'en'),
              // Agrega más opciones de idioma según sea necesario
            ],
          ),
        );
      },
    );
  }

  // Método para construir una opción de idioma en el diálogo
  Widget _languageOption(BuildContext context, String languageName, String languageCode) {
    return ListTile(
      title: Text(languageName),
      onTap: () {
        _changeLanguage(context, languageCode);
        Navigator.pop(context); // Cerrar el diálogo después de seleccionar un idioma
      },
    );
  }

  // Método para cambiar el idioma y guardar la selección en SharedPreferences
  _changeLanguage(BuildContext context, String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    setState(() {
      _selectedLanguage = languageCode; // Actualizar el idioma seleccionado en la pantalla
    });
    // Puedes añadir lógica adicional aquí, como recargar la interfaz de usuario para que los cambios surtan efecto
  }
}
