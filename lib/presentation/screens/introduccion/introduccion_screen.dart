import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class TouristGuideScreen extends StatefulWidget {
  @override
  _TouristGuideScreenState createState() => _TouristGuideScreenState();
}

class _TouristGuideScreenState extends State<TouristGuideScreen> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    // Cargar el PDF desde los assets
    _pdfController = PdfController(
      document: PdfDocument.openAsset('assets/guiapdf/GUIA-TURISTICA-EL-COCA.pdf'),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guía Turística'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade600,
      ),
      body: PdfView(
        controller: _pdfController,
        scrollDirection: Axis.vertical, // Puedes cambiar a Axis.horizontal si prefieres
        onPageChanged: (page) {
          debugPrint('Página actual: $page');
        },
      ),
    );
  }
}
