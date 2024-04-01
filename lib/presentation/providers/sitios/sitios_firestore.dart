import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/entities/entities.dart';

class FirestoreService {
  final CollectionReference sitiosCollection = FirebaseFirestore.instance.collection('sitios');
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
      return ''; // Si no se encuentra el campo 'name_cate' o el documento no existe
    } catch (e) {
      print('Error al obtener el nombre de la categoría: $e');
      return ''; // Manejo de errores devolviendo una cadena vacía
    }
  }

  Future<List<Sitio>> getSitesByCategory(String categoryName) async {
    try {
      QuerySnapshot categoryQuerySnapshot = await categoriasCollection.where('name_cat', isEqualTo: categoryName).get();
      if (categoryQuerySnapshot.docs.isNotEmpty) {
        // Obtenemos la referencia al documento de la categoría
        DocumentReference categoryReference = categoryQuerySnapshot.docs.first.reference;
        // Consultamos los sitios que tienen esa referencia como categoría
        QuerySnapshot sitiosQuerySnapshot = await sitiosCollection.where('category', isEqualTo: categoryReference).get();
        return sitiosQuerySnapshot.docs.map((doc) => Sitio.fromFirestore(doc)).toList();
      } else {
        return []; // Devuelve una lista vacía si no se encuentra la categoría
      }
    } catch (e) {
      print('Error al obtener sitios por categoría: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }
  Future<List<Sitio>> getSitesByCategories(List<String> categories) async {
    try {
      // Buscamos las referencias a los documentos de las categorías en base a los nombres proporcionados
      QuerySnapshot categoryQuerySnapshot = await categoriasCollection.where('name_cat', whereIn: categories).get();

      // Obtenemos las referencias de los documentos de categorías
      List<DocumentReference> categoryReferences = categoryQuerySnapshot.docs.map((doc) => doc.reference).toList();

      // Consultamos los sitios que tengan cualquiera de estas referencias como categoría
      QuerySnapshot sitiosQuerySnapshot = await sitiosCollection.where('category', whereIn: categoryReferences).get();

      return sitiosQuerySnapshot.docs.map((doc) => Sitio.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error al obtener sitios por categorías: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }


  Future<List<Sitio>> getSites() async {
    try {
      QuerySnapshot querySnapshot = await sitiosCollection.get();
      return querySnapshot.docs.map((doc) => Sitio.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error al obtener los sitios: $e');
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
