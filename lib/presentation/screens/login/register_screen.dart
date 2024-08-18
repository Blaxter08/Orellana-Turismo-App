import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      child: Column(
        children: [

          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Usuario'),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Correo Electrónico'),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20),
          IntlPhoneField(
            controller: _phoneController,
            // decoration: InputDecoration(labelText: 'Número de Teléfono'),
            initialCountryCode: 'US',
            onChanged: (phone) {
              _phoneNumber = phone.completeNumber;
              print(_phoneNumber);
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Dirección'),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _registerUser();
            },
            child: Text('Registrarse'),
          ),
        ],
      ),
    );
  }

  void _registerUser() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final address = _addressController.text.trim();
    final password = _passwordController.text.trim();

    // Validar campos antes de continuar
    if (username.isEmpty ||
        email.isEmpty ||
        _phoneNumber == null ||
        address.isEmpty ||
        password.isEmpty) {
      // Mostrar mensaje de error si algún campo está vacío
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor complete todos los campos')),
      );
      return;
    }

    try {
      // Crear cuenta de usuario en Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar los datos del usuario en Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'displayName': username,
        'email': email,
        'phoneNumber': _phoneNumber,
        'address': address,
        'password': password,
        'photoURL': '',
        // Opcional: Puedes agregar más campos aquí según sea necesario

      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado correctamente'), backgroundColor: Colors.green,),
      );
      // Redirigir al usuario a la pantalla de inicio de sesión
      GoRouter.of(context).go('/login');
    } catch (error) {
      print('Error al registrar usuario: $error');
      // Mostrar mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar usuario. Por favor intenta de nuevo'), backgroundColor: Colors.red,),
      );
    }
  }
}
