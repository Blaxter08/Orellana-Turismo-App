import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';

class AjustesScreen extends StatefulWidget {
  @override
  _AjustesScreenState createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  String _selectedLanguage = '';

  @override
  void initState() {
    _loadSelectedLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          ListTile(
            title: Text(localizations.changeLanguage),
            subtitle: Text(_selectedLanguage),
            onTap: () => _showLanguageDialog(context),
          ),
          ListTile(
            title: Text(localizations.changeTheme),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.nightlight_round),
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
                Icon(Icons.wb_sunny),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('language') ?? 'en';
    setState(() {
      _selectedLanguage = language;
    });
  }

  _showLanguageDialog(BuildContext context) {
    final localizations = S.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.selectLanguage),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption(context, 'Español', 'es'),
              _languageOption(context, 'English', 'en'),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(BuildContext context, String languageName, String languageCode) {
    return ListTile(
      title: Text(languageName),
      onTap: () {
        _changeLanguage(context, languageCode);
        Navigator.pop(context);
      },
    );
  }

  _changeLanguage(BuildContext context, String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    MyApp.of(context)?.setLocale(Locale(languageCode));
    setState(() {
      _selectedLanguage = languageCode;
    });
  }
}
