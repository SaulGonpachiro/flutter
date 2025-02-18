import 'package:flutter/material.dart';
import 'package:Paw_authority/UI/background_image.dart';
import 'package:Paw_authority/screens/petcrud/ejemplo_crud_pets.dart'; // Asegúrate de importar la pantalla de mascotas
import 'package:Paw_authority/UI/background_image.dart';

class PetsScreen extends StatelessWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          const BackgroundImage(imagen: "huron.png"),

          // Contenido centrado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Título en la parte superior
              children: [
                // Título principal
                const Padding(
                  padding: EdgeInsets.only(top: 40), // Espacio en la parte superior
                  child: Text(
                    'Bienvenido a "Respect My Paw-thority!"',
                    style: TextStyle(
                      color: Colors.greenAccent, // Color greenAccent
                      fontSize: 32, // Tamaño más grande
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Espacio entre el título y los botones

                // Botones en horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImageButton(context, "Clientes", "assets/images/clientes.png", '/clients'),
                    const SizedBox(width: 20), // Espacio entre botones
                    _buildImageButton(context, "Mascotas", "assets/images/mascotas.png", '/ejemplo'),
                    const SizedBox(width: 20), // Espacio entre botones
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
      children: [
        // Título arriba de la imagen
        Text(
          title,
          style: const TextStyle(
            color: Colors.greenAccent, // Color greenAccent
            fontSize: 24, // Tamaño más grande
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10), // Espacio entre el título y la imagen

        // Imagen con GestureDetector
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Bordes redondeados
            child: Image.asset(
              imagePath,
              width: 400, // Imágenes más grandes
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}