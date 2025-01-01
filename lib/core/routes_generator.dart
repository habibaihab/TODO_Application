import 'package:flutter/material.dart';
import 'package:todo_project/core/page_routes_names.dart';
import 'package:todo_project/modules/layout_view.dart';
import 'package:todo_project/modules/tasks/edit_task/edit_task.dart';

import '../modules/login/login_view.dart';
import '../modules/registration/registration_view.dart';
import '../modules/splash/splash_view.dart';

class RouteGenerator{

   static Route<dynamic> onGenerateRoute(RouteSettings settings){
     switch(settings.name){
       case PageRouteName.initial:
         return MaterialPageRoute(
             builder: (context) => const SplashView(),
         settings: settings);
       case PageRouteName.layout:
         return MaterialPageRoute(
             builder: (context) => const LayOutView(),
             settings: settings);

       case PageRouteName.login:
         return MaterialPageRoute(builder: (context)=> const LoginView(),
         settings: settings);
       case PageRouteName.registration:
         return MaterialPageRoute(builder: (context)=> const RegistrationView(),
             settings: settings
         );
       case PageRouteName.edit:
         return MaterialPageRoute(builder: (context)=> const EditTask(),
             settings: settings
         );

       default:
         return MaterialPageRoute(builder: (context)=> const SplashView(),
         );
     }
   }


}