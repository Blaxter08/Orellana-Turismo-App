import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/sitios.dart';
// Asegúrate de cambiar 'your_project_name' por el nombre real de tu proyecto

class SitioCard extends StatelessWidget {
  final Sitio sitio;

  SitioCard({required this.sitio});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: 150,
        color: Colors.deepOrange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(sitio.name),
            ClipRRect(
                child: Image.network(sitio.img)),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Sitio sitio;

  final String title;
  final String imageUrl;
  final String description;

  CustomCard({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.sitio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Container(
        width: 130,
        height: 150,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sitio.name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            Image.network(
              sitio.img,
              width: 100,
              height: 60,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                sitio.description,
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
