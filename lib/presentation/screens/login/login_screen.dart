import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:turismo_app/presentation/widgets/widgets.dart';

import '../../../infrastructure/providers/login/signInEmail.dart';
import '../../../infrastructure/providers/login/signInWithGoogle.dart';
import '../../../infrastructure/providers/shared_preferences/saveUserData.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Login_Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              card_Container(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Inicar Sesión', style: GoogleFonts.roboto(fontSize :30, fontWeight: FontWeight.bold) , ),
                    SizedBox(height: 10),
                    _LoginForm(),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  // Iniciar sesión con Google al presionar el botón
                  User? user = await GoogleSignInProvider().signInWithGoogle();
                  print(user);
                  if (user != null)  {
                  //   print('Usuario ${user.displayName} ha iniciado sesión');
                  await  saveUserUid(user.uid);
                    Future.delayed(Duration(milliseconds: 100), () {
                      context.go('/home');
                    });
                  } else {
                    print('Error al iniciar sesión con Google');
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.login, color: Colors.black87),
                    SizedBox(width: 10),
                    Text('Iniciar sesión con Google', style: TextStyle(fontSize: 18, color: Colors.black87)),
                  ],
                ),
              ),
              SizedBox(height: 50),
              TextButton(
                onPressed: () => context.go('/register'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.green.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                ),
                child: Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              style: TextStyle(fontSize: 18, color: Colors.black87),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInpuDecoration(
                hintText: 'Pepe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_sharp,
              ),
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'Ingresa un correo válido';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _passwordController,
              style: TextStyle(fontSize: 18),
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.loginInpuDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.app_blocking_outlined,
              ),
              validator: (value) {
                return (value != null && value.length >= 6) ? null : 'La contraseña debe ser mayor a 6 caracteres';
              },
            ),
            SizedBox(height: 15),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.green,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () async {
                // Acción al presionar el botón de ingresar
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                // Validar credenciales
                String? uid = await AuthService().validateCredentials(email, password);
                if (uid != null) {
                  // Credenciales válidas, guardar el UID del usuario en SharedPreferences
                  await saveUserUid(uid);
                  Future.delayed(Duration(milliseconds: 100), () {
                    context.go('/home');
                  });
                } else {
                  // Credenciales inválidas, mostrar un mensaje de error
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Correo electrónico o contraseña incorrectos'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
