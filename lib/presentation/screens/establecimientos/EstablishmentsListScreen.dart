import 'package:flutter/material.dart';
import '../../../domain/entities/establecimientos.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/providers/establecimientos/establishment_service.dart';
import '../../widgets/establecimientos/establishment_card.dart';
import '../sitios/sitios_custom_detail_screnn.dart';
import 'Establishments_detail_screen.dart';


class EstablishmentsListScreen extends StatefulWidget {
  final String category;

  const EstablishmentsListScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _EstablishmentsListScreenState createState() => _EstablishmentsListScreenState();
}

class _EstablishmentsListScreenState extends State<EstablishmentsListScreen> {
  final EstablishmentService _establishmentService = EstablishmentService();
  List<Establishment> _allEstablishments = [];
  List<Establishment> _filteredEstablishments = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _establishmentService.getEstablishmentsByCategory(widget.category).listen((establishments) {
      setState(() {
        _allEstablishments = establishments;
        _filteredEstablishments = establishments;
      });
    });
  }

  void _filterEstablishments(String query) {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      _filteredEstablishments = _allEstablishments.where((establishment) {
        final nameMatch = establishment.nombre.toLowerCase().contains(lowerCaseQuery);
        final subCategoryMatch = establishment.subCategoria.toLowerCase().contains(lowerCaseQuery);
        final ratingMatch = establishment.puntuacion.toString().contains(lowerCaseQuery);
        return nameMatch || subCategoryMatch || ratingMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).establishmentsWithCategory(widget.category)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                _filterEstablishments(query);
              },
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, subcategoría o puntuación',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredEstablishments.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No se encontraron establecimientos',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 3 / 4,
              ),
              itemCount: _filteredEstablishments.length,
              itemBuilder: (context, index) {
                final establishment = _filteredEstablishments[index];
                return EstablishmentCard(
                  establishment: establishment,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EstablishmentDetailsScreen(establishment: establishment, establishmentId: establishment.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
