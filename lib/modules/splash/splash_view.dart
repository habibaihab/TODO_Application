import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_project/core/page_routes_names.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState(){
    Timer(
      Duration(seconds: 2)
    , () {
        Navigator.pushReplacementNamed(context, PageRouteName.login);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/splash_background.png"),
        fit: BoxFit.cover)
      ),
    );
  }
}
