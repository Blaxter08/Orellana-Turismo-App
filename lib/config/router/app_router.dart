

import 'package:go_router/go_router.dart';
import 'package:turismo_app/presentation/screens/favorites/favorite_screen.dart';

import 'package:turismo_app/presentation/screens/screens.dart';
import 'package:turismo_app/presentation/screens/sitios/home_screen_view.dart';


final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      
      ShellRoute(
        builder: (context, state,child){
          return HomeScreen(childView: child);
        },
        routes: [
          GoRoute(
              path:'/',
            builder: (context,state){
                return Home_Screen_View();
            }
          ),
       GoRoute(
              path:'/categories',
            builder: (context,state){
                return CategoriesScreen();
            }
          ),GoRoute(
              path:'/favorites',
            builder: (context,state){
                return FavoriteScreen();
            }
          ),

        ]
      )

      
      // GoRoute(
      //     path: '/',
      //     name: HomeScreen.name,
      //     builder: (context,state) => HomeScreen(childView: Home_Screen_View()),
      // ),
      //  GoRoute(
      //     path: '/categories',
      //     builder: (context,state) {
      //       return const CategoriesScreen();
      //     },
      // ),

    ]
);