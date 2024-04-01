import 'package:flutter/material.dart';

import '../../widgets/sitios/sitios_export.dart';
import '../../widgets/widgets.dart';


class Home_Screen_View extends StatelessWidget {

  const Home_Screen_View({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // CustomAppbar(),
        // Container(
        //   padding: EdgeInsets.only(left: 50),
        //     alignment: Alignment.topLeft,
        //     child: Text('Eventos',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ), textAlign: TextAlign.right,)),
        //
        EventsSlideShow(),
        SizedBox(height: 20,),
        SitiosSlideShow()
        ,SizedBox(height: 20,),
        ComidasBebidas_SlideShow(),



        // SitiosSlideShow(),
      ],
    );
  }
}
//
// class Home_Screen_View extends StatefulWidget {
//   const Home_Screen_View({super.key});
//
//   @override
//   State<Home_Screen_View> createState() => _Home_Screen_ViewState();
// }
//
// class _Home_Screen_ViewState extends State<Home_Screen_View> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         // CustomAppbar(),
//         // Container(
//         //   padding: EdgeInsets.only(left: 50),
//         //     alignment: Alignment.topLeft,
//         //     child: Text('Eventos',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, ), textAlign: TextAlign.right,)),
//         //
//         EventsSlideShow(),
//         SizedBox(height: 20,),
//         SitiosSlideShow()
//         ,SizedBox(height: 20,),
//         ComidasBebidas_SlideShow(),
//
//
//
//         // SitiosSlideShow(),
//       ],
//     );
//   }
// }
