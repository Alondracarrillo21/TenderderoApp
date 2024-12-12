import 'package:flutter/material.dart';
import 'screen/login_screen.dart'; // Asegúrate de que el archivo login_screen.dart exista en esta ruta

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TendederoSmart - Inicio de Sesión',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Usa LoginScreen como pantalla principal
    );
  }
}
