import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:turismo_app/presentation/screens/screens.dart';

import '../../widgets/sitios/sitios_export.dart';
import '../../widgets/widgets.dart';

class Home_Screen_View extends StatefulWidget {
  const Home_Screen_View({Key? key}) : super(key: key);

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<Home_Screen_View> {
  bool _hasInternetConnection = true; // Variable para almacenar el estado de la conexión a Internet

  @override
  void initState() {
    super.initState();
    _checkInternetConnection(); // Verificar la conexión a Internet al iniciar el widget
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _hasInternetConnection = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _hasInternetConnection
        ? CustomScrollView(
      slivers: [
        // SliverAppBar(
        //   floating: true,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: CustomAppbar(),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SitiosSlideShow(),
              ComidasBebidas_SlideShow(),
            ],
          ),
        ),
      ],
    )
        : Center(
      child: Text("Ahora no tienes conexión a Internet"),
    );
  }
}
