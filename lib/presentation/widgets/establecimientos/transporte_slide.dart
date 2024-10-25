import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/providers/establecimientos/establishment_provider.dart';
import '../../../domain/entities/establecimientos.dart';
import '../../screens/establecimientos/Establishments_detail_screen.dart';

class TransporteGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final establecimientosAsync = ref.watch(transporteProvider);

    return establecimientosAsync.when(
      data: (establecimientos) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Espacio adicional antes del título
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
            child: Text(
              'Operadoras Turísticas y Transporte',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // GridView para los establecimientos
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Para permitir que el Grid se muestre dentro de un ScrollView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columnas
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // Controla la relación de aspecto del Grid
              ),
              itemCount: establecimientos.length,
              itemBuilder: (context, index) {
                final establishment = establecimientos[index];
                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de detalles cuando se hace tap en un establecimiento
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EstablishmentDetailsScreen(
                          establishment: establishment, establishmentId: '',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5, // Añade una sombra suave
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/jar-loading.gif',
                              image: establishment.logoUrl.isNotEmpty
                                  ? establishment.logoUrl
                                  : 'assets/no-image.png',
                              fit: BoxFit.cover,
                              fadeInDuration: Duration(milliseconds: 200),
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            establishment.nombre,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                establishment.puntuacion.toString(),
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            establishment.direccion,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error al cargar establecimientos')),
    );
  }
}
