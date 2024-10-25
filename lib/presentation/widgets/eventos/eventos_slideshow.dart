import 'package:flutter/material.dart';

class EventosWidget extends StatelessWidget {
  final List<dynamic> eventos; // Lista de eventos

  const EventosWidget({Key? key, required this.eventos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Si no hay eventos, no retorna nada
    if (eventos.isEmpty) {
      return SizedBox.shrink(); // Retorna un widget vacío
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            "Próximos Eventos",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: eventos.length, // Muestra el número de eventos
            itemBuilder: (context, index) {
              final evento = eventos[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(evento['imageUrl']), // URL de la imagen del evento
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                evento['nombre'], // Nombre del evento
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                evento['fecha'], // Fecha del evento
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
