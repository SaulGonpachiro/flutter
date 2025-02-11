import 'package:flutter/material.dart';
import 'package:flutter_appvet/providers/pet_provider.dart';
import 'package:flutter_appvet/screens/EjemploCRUDScreen.dart';
import 'package:flutter_appvet/screens/LoginScreen.dart';
import 'package:flutter_appvet/screens/PetsScreen.dart';
import 'package:flutter_appvet/screens/Screens.dart';
import 'package:flutter_appvet/services/pets_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => AuthService()), // Proveedor del servicio de autenticación
        ChangeNotifierProvider(create: (_) => PetsService()),
        ChangeNotifierProvider(create: (_) => PetProvider())

        
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Vet',
      initialRoute: '/ejemplo',
      routes: {
      '/login' : (context) =>LoginScreen(),
      '/pets/' : (context) => Petsscreen(),
      '/vaccination' : (context) => Vaccinationscreen(),
      '/ejemplo': (context) => EjemploCRUD()
      },
    );
  }
}