import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turismo_app/presentation/widgets/login/card_container.dart';
import 'package:turismo_app/presentation/widgets/login/login.dart';
import '../../../infrastructure/providers/login/signInEmail.dart';
import '../../../infrastructure/providers/login/signInWithGoogle.dart';
import '../../../infrastructure/providers/shared_preferences/saveUserData.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              card_Container(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Iniciar Sesión',
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal
                      ),
                    ),
                    SizedBox(height: 10),
                    _LoginForm(),
                  ],
                ),
              ),
              SizedBox(height: 40),
              _GoogleLoginButton(),
              SizedBox(height: 20),
              _CreateAccountButton(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        User? user = await GoogleSignInProvider().signInWithGoogle();
        if (user != null) {
          await saveUserUid(user.uid);
          context.go('/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al iniciar sesión con Google')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 5,
      ),
      // icon: Icon(Icons., color: Colors.black87),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/google.png', fit: BoxFit.cover,
          width: 20,
          height: 20,
          ),
          SizedBox(width: 10,),
          Text(
            'Iniciar sesión con Google',
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.push('/register'), // Cambiado go() por push()
      style: TextButton.styleFrom(
        foregroundColor: Colors.teal,
        textStyle: TextStyle(fontSize: 18),
      ),
      child: Text('Crear una nueva cuenta'),
    );
  }
}


class _LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.loginInputDecoration(
              hintText: 'Pepe@gmail.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.alternate_email_sharp,
            ),
            validator: (value) {
              return _validateEmail(value);
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecorations.loginInputDecoration(
              hintText: '******',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
            ),
            validator: (value) {
              return _validatePassword(value);
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await _submitForm(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Ingresar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value ?? '') ? null : 'Ingresa un correo válido';
  }

  String? _validatePassword(String? value) {
    return (value != null && value.length >= 6)
        ? null
        : 'La contraseña debe ser mayor a 6 caracteres';
  }

  Future<void> _submitForm(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String? uid = await AuthService().validateCredentials(email, password);

    if (uid != null) {
      await saveUserUid(uid);
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Correo electrónico o contraseña incorrectos'),
            backgroundColor: Colors.red),
      );
    }
  }
}

class InputDecorations {
  static InputDecoration loginInputDecoration({
    required String hintText,
    required String labelText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.teal),
      ),
      hintText: hintText,
      labelText: labelText,
      prefixIcon: Icon(prefixIcon, color: Colors.teal),
      labelStyle: TextStyle(color: Colors.grey),
    );
  }
}
