import 'package:flutter/material.dart';
import 'package:Paw_authority/UI/background_image.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(imagen: "huron.png"),

          // Contenido centrado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Bienvenido a "Respect My Paw-thority!"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Contenedor flexible con distribución automática
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15, // Espacio horizontal entre imágenes
                  runSpacing: 15, // Espacio vertical entre imágenes
                  children: [
                    _buildImageButton(context, "Clientes", "assets/images/clientes.png", '/clients'),
                    _buildImageButton(context, "Mascotas", "assets/images/mascotas.png", '/ejemplo'),
                    _buildImageButton(context, "Citas", "assets/images/citas.png", '/appointments'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageButton(BuildContext context, String title, String imagePath, String route) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 120, // Tamaño más pequeño para que entren sin scroll
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
