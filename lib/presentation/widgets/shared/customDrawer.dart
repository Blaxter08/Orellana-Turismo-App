import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_app/presentation/screens/screens.dart';
import '../../../infrastructure/providers/shared_preferences/saveUserData.dart'; // Importa SharedPreferences

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    // color: Colors.green.shade300,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                        future: _getUserData(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error al cargar los datos del usuario');
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return Text('El usuario no tiene datos asociados');
                            }
                            Map<String, dynamic>? userData = snapshot.data!.data() as Map<String, dynamic>?;
                            String displayName = userData?['displayName'] ?? 'Nombre de Usuario';
                            String email = userData?['email'] ?? 'usuario@example.com';
                            String photoURL = userData?['photoUrl'] ?? '';

                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: photoURL != null && photoURL.isNotEmpty
                                      ? NetworkImage(photoURL)
                                      : AssetImage('assets/usuario.png') as ImageProvider<Object>,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  displayName,
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                    // color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SpinKitFadingCube(
                              color: Colors.white,
                              size: 50.0,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text('Mi cuenta'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserProfileScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Ayuda'),
                  onTap: () {
                    // Lógica para la opción 1
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Ayuda'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AyudaScreen(),
                      ),
                    );
                    // Lógica para la opción 1
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Ajustes'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AjustesScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip_outlined),
                  title: Text('Política de Privacidad'),
                  onTap: () {
                    // Lógica para la opción 1
                  },
                ),

              ],
            ),
          ),


          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              clearUserPreferences().then((_) {
                context.go('/login');
              });
            },
          ),
        ],
      ),
    );
  }

  Future<DocumentSnapshot> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? uid = await _getUserUidFromSharedPreferences();
    return FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

  Future<String?> _getUserUidFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }
}
