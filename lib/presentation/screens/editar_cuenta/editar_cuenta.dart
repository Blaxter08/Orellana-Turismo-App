import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/theme/appbar_theme.dart';
import '../../../infrastructure/providers/userFireService/userFireService.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _photoUrlController = TextEditingController();

  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final String user = FirebaseAuth.instance.currentUser!.uid;
    print(user);
    Map<String, dynamic>? userData = await UserRepository.getUserData(user);

    if (userData != null) {
      setState(() {
        _addressController.text = userData['address'];
        _displayNameController.text = userData['displayName'];
        _emailController.text = userData['email'];
        _passwordController.text = userData['password'];
        _phoneNumberController.text = userData['phoneNumber'];
        _photoUrlController.text = userData['photoUrl'];
      });
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveChanges() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      // Actualizar los datos del usuario en Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'address': _addressController.text,
        'displayName': _displayNameController.text,
        'phoneNumber': _phoneNumberController.text,
      });

      // Si se seleccionó una nueva imagen, subirla a Firebase Storage y actualizar la URL de la foto
      if (_image != null) {
        String imageUrl = await _uploadImageToStorage(userId);
        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'photoUrl': imageUrl,
        });
      }

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cambios guardados correctamente')),
      );
    } catch (error) {
      // Manejar errores
      print('Error al guardar los cambios: $error');
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar los cambios')),
      );
    }
  }

  Future<String> _uploadImageToStorage(String userId) async {
    try {
      // Subir la nueva imagen al almacenamiento (Storage) de Firebase
      final Reference storageRef = FirebaseStorage.instance.ref().child('user_images').child('$userId.jpg');
      await storageRef.putFile(_image!);

      // Obtener la URL de la imagen subida
      final String imageUrl = await storageRef.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (error) {
      print('Error al subir la imagen: $error');
      // Si hay un error, retornar una cadena vacía
      return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: CustomAppBarColor.appBarColor, // Color de fondo del AppBar
        title: Text('Editar perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: _image != null
                        ? DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                    )
                        : (_photoUrlController.text.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(_photoUrlController.text),
                      fit: BoxFit.cover,
                    )
                        : DecorationImage(
                      image: AssetImage('assets/no-image.png'),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
                FloatingActionButton(
                  onPressed: _getImage,
                  child: Icon(Icons.add),
                  mini: true, // Hacer el botón más pequeño
                ),
              ],
            ),
            Container(
              // color: Colors.grey,
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
            ),
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _emailController,
              decoration:
              InputDecoration(labelText: 'Correo electrónico'),
              enabled: false,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _phoneNumberController,
              decoration:
              InputDecoration(labelText: 'Número de teléfono'),
            ),
            // TextField(
            //   controller: _photoUrlController,
            //   decoration: InputDecoration(labelText: 'URL de la foto'),
            // ),
          ],
        ),
      ),
    );
  }
}
