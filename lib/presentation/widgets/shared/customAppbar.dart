import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final tittleStyle = Theme.of(context).textTheme.titleMedium;
    return  SafeArea(
      bottom: false,
        child:Padding(
            padding:const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.map, color: ThemeData().primaryColor,),
                  Text('Turismo FCO',style: tittleStyle,),
                  Spacer(                  ),



                  IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.search)
                  ),
                ],
              ),
            ),
        )
    );
  }
}
