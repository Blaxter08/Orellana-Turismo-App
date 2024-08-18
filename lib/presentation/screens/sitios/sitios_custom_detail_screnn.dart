import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turismo_app/domain/entities/sitios.dart';

import '../../widgets/widgets.dart';

class SitioCustomDetailScreen extends StatelessWidget {
  final Sitio sitio;
  final String sitioId; // Agregar el ID del documento del sitio como parámetro

  const SitioCustomDetailScreen({Key? key, required this.sitio, required this.sitioId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(sitio: sitio),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _SitioDetails(sitio: sitio, sitioId: sitioId), // Pasar el ID del documento del sitio
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SitioDetails extends StatelessWidget {
  final Sitio sitio;

  const _SitioDetails({Key? key, required this.sitio, required String sitioId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Text(
            sitio.name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.location_on, color: Colors.red),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  sitio.direction,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Icon(Icons.phone, color: Colors.green),
          //     SizedBox(width: 5),
          //     Expanded(
          //       child: Text(
          //         sitio.telefono,
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(
          //           fontSize: 17,
          //           color: Colors.black38,
          //           fontWeight: FontWeight.normal,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialMediaIcon('assets/whatsapp.png'),
            _buildSocialMediaIcon('assets/facebook.png'),
            _buildSocialMediaIcon('assets/instagram.png'),
            _buildSocialMediaIcon('assets/tik-tok.png'),
          ],
        ),
          // DescripcionWidget(description: sitio.description),
          SizedBox(height: 10),
          _buildTabBar(), // Agregamos el TabBar aquí
        ],
      ),
    );
  }
  Widget _buildSocialMediaIcon(String imagePath) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _buildTabBar() {
    return DefaultTabController(
      length: 3, // Número de pestañas
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            dividerColor: Colors.grey,
            // labelColor: Colors.grey,
            // unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'Descripción'),
              Tab(text: 'Servicios'),
              Tab(text: 'Comentarios'),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 370, // Ajusta la altura según sea necesario
            child: TabBarView(
              children: [
                DescripcionWidget(description: sitio.description),
                _ServiciosWidget(servicios: sitio.services,),
                // _ComentariosWidget(sitioId: sitio.,),
                ComentariosWidget(sitioId: sitio.idSitio)
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _DescripcionWidget extends StatelessWidget {
  final String description;

  const _DescripcionWidget({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(description, style: GoogleFonts.roboto(
          fontSize:17,
          color: Colors.grey,
        ),
        textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
class _ServiciosWidget extends StatelessWidget {
  final List<String> servicios;

  const _ServiciosWidget({Key? key, required this.servicios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: servicios.map((servicio) {
            return Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text(servicio, style: GoogleFonts.roboto(
                  fontSize:17,
                ),),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

class DescripcionWidget extends StatefulWidget {
  final String description;

  const DescripcionWidget({Key? key, required this.description}) : super(key: key);

  @override
  _DescripcionWidgetState createState() => _DescripcionWidgetState();
}

class _DescripcionWidgetState extends State<DescripcionWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = !_expanded;
            });
          },
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 300),
            firstChild: Text(
              widget.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize:17,
                color:Colors.grey,
              ),
            ),
            secondChild: Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                fontSize:17,
                color:Colors.grey,
              ),
            ),
            crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ),
        if (!_expanded)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _expanded = true;
                  });
                },
                child: Text(
                  "Leer más",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),

      ],
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {
  final Sitio sitio;

  const _CustomSliverAppBar({Key? key, required this.sitio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: size.height * 0.3,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                sitio.img,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [Colors.transparent, Colors.black45],
                  ),
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [Colors.black38, Colors.transparent],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
