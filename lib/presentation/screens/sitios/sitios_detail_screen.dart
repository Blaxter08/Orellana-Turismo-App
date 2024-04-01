import 'package:flutter/material.dart';
import 'package:turismo_app/domain/entities/sitios.dart';

class SitioDetailScreen extends StatelessWidget {
  final Sitio sitio;

  const SitioDetailScreen({Key? key, required this.sitio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sitio.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  sitio.img,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildDetailItem('Dirección', sitio.direction),
            _buildDetailItem('Teléfono', sitio.telefono),
            _buildDetailItem('Descripción', sitio.description),
            _buildDetailItem('Puntuación', '${sitio.puntuation}'),
            SizedBox(height: 20),
            _buildServiceSection(sitio.services),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          content,
          style: TextStyle(
            color: Colors.blueGrey[700],
            fontSize: 16,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildServiceSection(List<String> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Servicios',
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: services.map((service) => _buildServiceItem(service)).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildServiceItem(String service) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
            size: 20,
          ),
          SizedBox(width: 5),
          Text(
            service,
            style: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
