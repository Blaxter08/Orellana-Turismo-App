import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turismo_app/presentation/screens/screens.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/providers/shared_preferences/saveUserData.dart';
import '../../../infrastructure/providers/userFireService/UserProvider.dart';
import '../../screens/introduccion/introduccion_screen.dart'; // Importa SharedPreferences


class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSnapshot = ref.watch(userProvider);

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
                  child: userSnapshot.when(
                    data: (data) {
                      if (data == null || !data.exists) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage('assets/usuario.png'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Nombre de Usuario',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'usuario@example.com',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      }
                      Map<String, dynamic>? userData = data.data() as Map<String, dynamic>?;
                      String displayName = userData?['displayName'] ?? 'Nombre de Usuario';
                      String email = userData?['email'] ?? 'usuario@example.com';
                      String photoURL = userData?['photoUrl'] ?? '';

                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: photoURL.isNotEmpty
                                ? NetworkImage(photoURL)
                                : AssetImage('assets/usuario.png') as ImageProvider<Object>,
                          ),
                          SizedBox(height: 10),
                          Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => Center(
                      child: SpinKitFadingCube(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                    error: (error, stack) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/usuario.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Error al cargar',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Intenta nuevamente',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text(S.of(context).my_account),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserProfileScreen(),
                      ),
                    );
                  },
                ),
                Divider(),
                // ListTile(
                //   leading: Icon(Icons.info_outline),
                //   title: Text('Ayuda'),
                //   onTap: () {
                //     // Lógica para la opción 1
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Guía Turística'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TouristGuideScreen(),
                      ),
                    );
                    // Lógica para la opción 1
                  },
                ),ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text(S.of(context).Help),
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
                  title: Text(S.of(context).settings),
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
