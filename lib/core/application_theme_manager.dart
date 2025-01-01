import 'package:flutter/material.dart';

class ApplicationThemeManager{
  static Color primaryLightColor =  const Color(0xFF5D9CEC);
  static ThemeData lightThemeData = ThemeData(

    primaryColor: primaryLightColor,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      toolbarHeight: 150,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.white,
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryLightColor,
        selectedIconTheme: IconThemeData(
          color:primaryLightColor,
          size: 35,
        ),
        unselectedIconTheme: const IconThemeData(
          size: 28,
    )

    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle(
        fontFamily: "Poppines",
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Poppines",
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: primaryLightColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppines",
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: primaryLightColor,
      ),
      displayMedium: TextStyle(
        fontFamily: "Poppines",
        fontWeight: FontWeight.normal,
        fontSize: 18,
        color: primaryLightColor,
      ),
      displaySmall: const TextStyle(
        fontFamily: "Poppines",
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black,
      ),
    ),


  );
}