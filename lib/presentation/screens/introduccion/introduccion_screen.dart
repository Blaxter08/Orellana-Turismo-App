import 'dart:ui';

import 'package:flutter/material.dart';

class TouristGuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Aumenta la longitud según las pestañas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Guía Turística'),
          bottom: TabBar(
            isScrollable: true, // Esto permitirá que las pestañas se desplacen si son muchas
            tabs: [
              Tab(text: 'Introducción'),
              Tab(text: 'Datos del Cantón'),
              Tab(text: 'Vías de acceso'),
              Tab(text: 'Artesanías'),
              Tab(text: 'Nacionalidades'), // Nueva pestaña
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IntroductionSection(),
            CantonDataSection(),
            AccessRoutesSection(),
            HandicraftsRouteSection(),
            NationalitiesSection(),
          ],
        ),
      ),
    );
  }
}

class GuideSection extends StatelessWidget {
  final String title;
  final String content;

  const GuideSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroductionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen de fondo con desenfoque
        Positioned.fill(
          child: Image.asset(
            'assets/images/el_coca_portada1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // Capa de desenfoque
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Aplicar desenfoque
            child: Container(
              color: Colors.black.withOpacity(0.3), // Opcional: añade una capa semi-transparente
            ),
          ),
        ),
        // Contenido de la introducción
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Introducción',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'El objetivo de esta Guía Turística es promover el turismo en el cantón Francisco de Orellana. '
                        'Aquí los visitantes podrán encontrar información sobre los sitios turísticos, cultura local, '
                        'festividades y mucho más. \n\n'
                        'Además, se proporcionan datos útiles para planificar sus visitas, como lugares de alojamiento, '
                        'restaurantes, y rutas recomendadas. Esta guía está diseñada para ser su compañero durante su '
                        'viaje y asegurar que disfruten de todo lo que este maravilloso cantón tiene para ofrecer.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CantonDataSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/papiro.jpg', // Ruta de la imagen de fondo
              fit: BoxFit.cover, // Ajusta la imagen al tamaño de la pantalla
            ),
          ),
          // Capa de oscurecimiento
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Oscurece la imagen para hacer el texto legible
            ),
          ),
          // Contenido de los datos del cantón
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cantón Francisco de Orellana',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildDataRow('Población:', '72,795 habitantes (CPV 2010, Proyección 2020)'),
                    _buildDataRow('Extensión:', '7,047 km² (704,755 ha)'),
                    _buildDataRow('Altitud:', '100 a 720 msnm'),
                    _buildDataRow('Clima:', 'Húmedo tropical'),
                    _buildDataRow('Temperatura:', 'Promedio anual 26°C'),
                    _buildDataRow('Parroquia Urbana:', 'El Coca'),
                    _buildDataRow('Parroquias Rurales:',
                        'San José de Guayusa, Nuevo Paraíso, San Luis de Armenia, '
                            'El Dorado, García Moreno, La Belleza, Dayuma, Inés Arango, '
                            'Taracoa, Alejandro Labaka, El Edén'),
                    _buildDataRow('Precipitación:',
                        'Promedio anual de 3,000 mm, con mayor pluviosidad de febrero a abril, '
                            'y menor de agosto a octubre.'),
                    _buildDataRow('Hidrografía:',
                        'El principal río es el Napo, con afluentes como el Payamino, '
                            'Coca, Tiputini, Indillama, Añangu y Yuturi.'),
                    _buildDataRow('Ubicación:',
                        'Latitud: 0° 28\' 27" S, Longitud: 76° 59\' 05" O. Se encuentra en '
                            'la región amazónica del Ecuador.'),
                    _buildDataRow('Límites:',
                        'Norte: Cantón La Joya de los Sachas (Orellana) y Cantones Cascales y '
                            'Shushufindi (Sucumbíos).\nSur: Cantones Arajuno (Pastaza) y Tena (Napo).\n'
                            'Este: Cantón Aguarico (Orellana).\nOeste: Cantón Loreto (Orellana) y Tena (Napo).'),
                    SizedBox(height: 20),
                    Text(
                      'Mapa del Cantón',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Image.asset('assets/images/mapa_canton.png'), // Añade la imagen del mapa aquí
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white, // Texto blanco para que contraste
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.white), // Texto blanco para legibilidad
            ),
          ),
        ],
      ),
    );
  }
}
class AccessRoutesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/el_coca_portada1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Capa de desenfoque
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Aplicar desenfoque
              child: Container(
                color: Colors.black.withOpacity(0.4), // Opcional: añade una capa semi-transparente
              ),
            ),
          ),
          // Contenido principal
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Distancias hacia El Coca',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildDataRow('Desde Nueva Loja:', '95 km (1h30 min)'),
                    _buildDataRow('Desde Quito:', '309 km (5h30 min)'),
                    _buildDataRow('Desde Esmeraldas:', '539 km (10h00 min)'),
                    _buildDataRow('Desde Manta:', '610 km (11h00 min)'),
                    _buildDataRow('Desde Guayaquil:', '714 km (13h00 min)'),
                    _buildDataRow('Desde Cuenca:', '618 km (12h00 min)'),
                    _buildDataRow('Desde Loja:', '760 km (14h00 min)'),
                    SizedBox(height: 20),
                    Text(
                      'Vías de Acceso',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Vía Terrestre:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      'Desde Quito se puede llegar a El Coca utilizando la Troncal Amazónica E45. '
                          'Las cooperativas de transporte interprovincial ofrecen turnos diarios, '
                          'con rutas que varían entre 1 y 14 horas según la distancia.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Vía Aérea:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      'El Coca cuenta con vuelos diarios desde Quito, con una duración de 30 minutos, '
                          'y desde Guayaquil, con escala en Quito, en 90 minutos. Las aerolíneas que operan '
                          'son AEROREGIONAL y LATAM.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Telecomunicaciones:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      'El Coca dispone de servicios de telefonía convencional, celular e Internet, '
                          'ofrecidos por CNT, Movistar, Tuenti y Claro.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white, // Texto blanco para contraste
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
class HandicraftsRouteSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/papiro.jpg', // Ruta de la imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          // Capa de oscurecimiento
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Oscurece la imagen para mejorar la legibilidad del texto
            ),
          ),
          // Contenido principal
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ruta de las Artesanías',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pasear por el malecón de El Coca es mucho más que un simple recorrido. '
                          'Es una inmersión total en la cultura y naturaleza de la región. A lo largo de este camino, '
                          'se encuentran piezas artesanales únicas, como collares, pulseras y tejidos elaborados con semillas y fibras naturales.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    _buildCraftItem(
                      'Materiales Naturales',
                      'Las artesanías de El Coca destacan por el uso de materiales reciclados y sostenibles, '
                          'una práctica ancestral que ha perdurado a lo largo de generaciones.',
                      'assets/images/papiro.jpg',
                    ),
                    _buildCraftItem(
                      'Tejidos Artesanales',
                      'Tejidos vibrantes y coloridos, creados por las manos hábiles de artesanos locales, son un reflejo de la conexión con la naturaleza.',
                      'assets/images/papiro.jpg',
                    ),
                    _buildCraftItem(
                      'Semillas y Fibras',
                      'Las comunidades amazónicas utilizan semillas y fibras naturales para crear piezas que cuentan historias de sus orígenes y tradiciones.',
                      'assets/images/papiro.jpg',
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Conoce más sobre las tradiciones a través de los relatos de los artesanos, quienes te sumergirán en un diálogo intercultural único.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCraftItem(String title, String description, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen representativa de la artesanía
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          // Descripción de la artesanía
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.tealAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class NationalitiesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagen de fondo
        Positioned.fill(
          // child: Image.asset(
          //   'assets/images/Huaoranis.jpg', // Imagen representativa
          //   fit: BoxFit.cover,
          // ),
          child: Container(
            color: Colors.grey.shade300,
          ),
        ),
        // Capa de oscurecimiento
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.7), // Oscurece la imagen
          ),
        ),
        // Contenido principal
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título principal con fondo
                _buildTitleWithBackground('Nacionalidades del Cantón Francisco de Orellana'),

                SizedBox(height: 20),

                // Información sobre la nacionalidad Kichwa
                _buildNationality(
                  'Nacionalidad Kichwa',
                  'La nacionalidad Kichwa es la más numerosa del cantón, representando el 20% '
                      'de los habitantes. Viven a lo largo de las riberas del río Napo y cuentan con '
                      'un extenso territorio comunal. Hablan el idioma runa shimi, y su organización '
                      'social principal es el Ayllu.',
                  'assets/images/KICHWAS.jpg', // Imagen representativa
                ),
                SizedBox(height: 20),

                // Información sobre la nacionalidad Shuar
                _buildNationality(
                  'Nacionalidad Shuar',
                  'La nacionalidad Shuar se organiza principalmente en las parroquias de Dayuma, '
                      'Inés Arango y Taracoa. La familia extendida es la base de su estructura social, '
                      'y sus miembros practican la agricultura y la caza. También elaboran artesanías '
                      'y conocen las propiedades medicinales de las plantas.',
                  'assets/images/shuaras.jpg',
                ),
                SizedBox(height: 20),

                // Información sobre la nacionalidad Waorani
                _buildNationality(
                  'Nacionalidad Waorani',
                  'Los Waorani son originarios de esta región, ubicados en las parroquias Inés Arango, '
                      'Dayuma y Alejandro Labaka. Tradicionalmente cazadores y recolectores, hoy en día '
                      'muchos de ellos siguen viviendo en comunidades dispersas. Mantienen sus costumbres, '
                      'como el uso de plantas medicinales y sus rituales culturales.',
                  'assets/images/Huaoranis.jpg',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Método para construir la presentación de cada nacionalidad
  Widget _buildNationality(String title, String description, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Imagen de la nacionalidad
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),

        // Título de la nacionalidad con fondo
        _buildTitleWithBackground(title),

        SizedBox(height: 10),

        // Descripción de la nacionalidad
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // Método para crear el fondo del título
  Widget _buildTitleWithBackground(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7), // Fondo oscuro semitransparente
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.tealAccent, // Color del texto
        ),
      ),
    );
  }
}


