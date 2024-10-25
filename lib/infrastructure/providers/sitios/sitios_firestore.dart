import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/establecimientos.dart';
import '../../../domain/entities/eventos.dart';

class FirestoreService {
  final CollectionReference establecimientosCollection = FirebaseFirestore.instance.collection('establecimientos');
  final CollectionReference eventosCollection = FirebaseFirestore.instance.collection('eventos');
  final CollectionReference categoriasCollection = FirebaseFirestore.instance.collection('categories');

  Future<String> getCategoryName(String categoryId) async {
    try {
      DocumentSnapshot categorySnapshot = await categoriasCollection.doc(categoryId).get();
      if (categorySnapshot.exists) {
        Map<String, dynamic> data = categorySnapshot.data() as Map<String, dynamic>;
        if (data.containsKey('name_cat')) {
          return data['name_cat'] as String;
        }
      }
      return ''; // Si no se encuentra el campo 'name_cat' o el documento no existe
    } catch (e) {
      print('Error al obtener el nombre de la categoría: $e');
      return ''; // Manejo de errores devolviendo una cadena vacía
    }
  }

  Future<List<Establishment>> getEstablishmentsByCategory(String categoryName) async {
    try {
      QuerySnapshot categoryQuerySnapshot = await categoriasCollection.where('name_cat', isEqualTo: categoryName).get();
      if (categoryQuerySnapshot.docs.isNotEmpty) {
        // Obtenemos la referencia al documento de la categoría
        DocumentReference categoryReference = categoryQuerySnapshot.docs.first.reference;
        // Consultamos los establecimientos que tienen esa referencia como categoría
        QuerySnapshot establecimientosQuerySnapshot = await establecimientosCollection.where('category', isEqualTo: categoryReference).get();
        return establecimientosQuerySnapshot.docs.map((doc) => Establishment.fromMap(
            doc.id,
            doc.data() as Map<String, dynamic>,
            doc
        )).toList();
      } else {
        return []; // Devuelve una lista vacía si no se encuentra la categoría
      }
    } catch (e) {
      print('Error al obtener establecimientos por categoría: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  Future<List<Establishment>> getEstablishmentsByCategories(List<String> categories, {int limit = 10, int page = 1}) async {
    try {
      List<Establishment> establecimientos = [];

      // Calcula el índice de inicio para la paginación
      int startIndex = (page - 1) * limit;

      // Buscamos las referencias a los documentos de las categorías en base a los nombres proporcionados
      QuerySnapshot categoryQuerySnapshot = await categoriasCollection.where('name_cat', whereIn: categories).get();

      // Obtenemos las referencias de los documentos de categorías
      List<DocumentReference> categoryReferences = categoryQuerySnapshot.docs.map((doc) => doc.reference).toList();

      // Consultamos los establecimientos que tengan cualquiera de estas referencias como categoría, con límite y paginación
      Query establecimientosQuery = establecimientosCollection.where('category', whereIn: categoryReferences).orderBy(FieldPath.documentId);

      // Obtener el documento de inicio
      DocumentSnapshot? startDocument;
      if (startIndex > 0) {
        QuerySnapshot startQuerySnapshot = await establecimientosQuery.limit(startIndex).get();
        if (startQuerySnapshot.docs.isNotEmpty) {
          startDocument = startQuerySnapshot.docs.last;
        }
      }

      // Consultar los documentos después del documento de inicio
      QuerySnapshot establecimientosQuerySnapshot;
      if (startDocument != null) {
        establecimientosQuerySnapshot = await establecimientosQuery.startAfterDocument(startDocument).limit(limit).get();
      } else {
        establecimientosQuerySnapshot = await establecimientosQuery.limit(limit).get();
      }

      establecimientos = establecimientosQuerySnapshot.docs.map((doc) => Establishment.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
          doc // Pasar el DocumentSnapshot aquí
      )).toList();

      return establecimientos;
    } catch (e) {
      print('Error al obtener establecimientos por categorías: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  Future<List<Establishment>> getEstablishments() async {
    try {
      QuerySnapshot querySnapshot = await establecimientosCollection.get();
      return querySnapshot.docs.map((doc) => Establishment.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
          doc
      )).toList();
    } catch (e) {
      print('Error al obtener los establecimientos: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  Future<List<Evento>> getEvents() async {
    try {
      QuerySnapshot querySnapshot = await eventosCollection.get();
      return querySnapshot.docs.map((doc) => Evento.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error al obtener los eventos: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }
}
