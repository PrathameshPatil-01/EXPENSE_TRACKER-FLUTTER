import 'package:flutter/material.dart';

class AppTheme {

static final ThemeData lightTheme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 252, 236, 221),
    appBarTheme: const AppBarTheme(
      color: Color.fromARGB(255, 255, 140, 46),
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ),
    colorScheme:const ColorScheme.light(
      primary: Color.fromARGB(255, 255, 194, 136) ,
      onPrimary: Color.fromARGB(255, 255, 255, 255),
      primaryContainer: Color.fromARGB(255, 77, 76, 76),
      secondary: Color.fromARGB(255, 0, 0, 0),
      tertiary: Color.fromARGB(255, 255, 255, 255), 
      onSecondary:Color.fromARGB(255, 255, 140, 46),
    ),
    cardTheme:const CardTheme(
      elevation: 15,
      color: Color.fromARGB(255, 254, 167, 47),
    ),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(0, 0, 0, 1),
        fontSize: 22.0,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 254, 167, 47),)
      )
    ),
  );
 
  static final ThemeData darkTheme = ThemeData().copyWith(

    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 0, 173, 181),
      ),
    ),
    colorScheme:const ColorScheme.dark(
      primary: Color.fromARGB(255, 61, 63, 67),
      onPrimary: Color.fromARGB(255, 253, 253, 253),
      primaryContainer: Color.fromARGB(255, 61, 57, 57),
      secondary: Color.fromARGB(255, 0, 173, 181),
      tertiary: Color.fromARGB(255, 17, 18, 18),
      onSecondary:Color.fromARGB(255, 0, 173, 181),
    ),
    cardTheme: const CardTheme(
      color: Color.fromARGB(255, 61, 60, 60),
    ),
    iconTheme:const IconThemeData(
      color: Color.fromARGB(255, 0, 173, 181),
    ),
    textTheme:const TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 22.0,
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(179, 255, 255, 255),
        fontSize: 16.0,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 0, 173, 181))
      )
    ),
  );
}
