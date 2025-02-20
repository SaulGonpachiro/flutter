import 'package:Paw_authority/screens/petcrud/crud_clientes.dart';
import 'package:Paw_authority/screens/petcrud/crud_consultas.dart';
import 'package:flutter/material.dart';
import 'package:Paw_authority/providers/pet_provider.dart';
import 'package:Paw_authority/screens/LoginScreen.dart';
import 'package:Paw_authority/screens/PetsScreen.dart';
import 'package:Paw_authority/screens/Screens.dart';
import 'package:Paw_authority/screens/petcrud/pet_insertform.dart';
import 'package:Paw_authority/services/pet_service.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PetService()),
        ChangeNotifierProvider(create: (_) => PetProvider()),
      ],
      child: MyApp(),
    ),
  );

  // Cambiar el título de la pestaña después de un pequeño retraso
  Future.delayed(Duration(seconds: 1), () {
    html.document.title = "Paw-thority";  // Aquí pones el título que quieras
  });
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Vet',
      initialRoute: '/pets',
      routes: {
        '/login': (context) => LoginScreen(),
        '/pets': (context) => PetsScreen(),
        '/vaccination': (context) => VaccinationScreen(),
        '/ejemplo': (context) => EjemploCrudPets(),
        '/petinsert': (context) => PetInsertForm(),
        '/crudclientes': (context) => Clientes(),
        '/crudconsultas': (context) => Consultas()
      },
    );
  }
}

/*
  home: AuthWrapper()
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return authService.isLoggedIn ? HomeScreen() : LoginScreen();
  }
}
*/