import 'package:flutter/material.dart';
import 'package:Paw_authority/UI/background_image.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Fondo transparente
      body: Stack(
        children: [
          // Imagen de fondo que cubre toda la pantalla
          const BackgroundImage(imagen: "huron.png"),

          // Contenido centrado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Bienvenido a "Respect My Paw-thority!"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), // Texto en blanco para mejor contraste
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Botones con imágenes
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 15, // Espacio horizontal entre imágenes
                  runSpacing: 15, // Espacio vertical entre imágenes
                  children: [
                    _buildImageButton(context, "Clientes", "assets/images/clientes.png", '/crudclientes'),
                    _buildImageButton(context, "Mascotas", "assets/images/mascotas.png", '/crudpet'),
                    _buildImageButton(context, "Citas", "assets/images/citas.png", '/crudconsultas'),
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
            color: Color.fromARGB(255, 0, 0, 0), // Texto en blanco para mejor contraste
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 4), // Borde blanco
              borderRadius: BorderRadius.circular(10), // Bordes redondeados
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Bordes redondeados para la imagen
              child: Image.asset(
                imagePath,
                width: 120, // Tamaño de la imagen
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}