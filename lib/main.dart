import 'package:Paw_authority/models/Consultas.dart';
import 'package:Paw_authority/providers/client_provider.dart';
import 'package:Paw_authority/providers/consulta_provider.dart';
import 'package:Paw_authority/screens/petcrud/cliente_insertform.dart';
import 'package:Paw_authority/screens/petcrud/consulta_insertform.dart';
import 'package:Paw_authority/screens/petcrud/crud_clientes.dart';
import 'package:Paw_authority/screens/petcrud/crud_consultas.dart';
import 'package:Paw_authority/services/client_service.dart';
import 'package:Paw_authority/services/consulta_service.dart';
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
        ChangeNotifierProvider(create: (_) => ClientService()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => ConsultaService()),
        ChangeNotifierProvider(create: (_) => ConsultaProvider()),
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/pets': (context) => PetsScreen(),
        '/vaccination': (context) => VaccinationScreen(),
        '/crudpet': (context) => EjemploCrudPets(),
        '/petinsert': (context) => PetInsertForm(),
        '/crudclientes': (context) => Clientes(),
        '/clientinsert': (context) => ClientInsertForm(),
        '/consultatinsert': (context) => ConsultaInsertForm(),
        '/crudconsultas': (context) => ConsultaCrud()
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