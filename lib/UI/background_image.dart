import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagen;
  const BackgroundImage({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ocupa todo el ancho
      height: double.infinity, // Ocupa todo el alto
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/$imagen"), // Ruta de la imagen
          fit: BoxFit.cover, // Cubre toda la pantalla
        ),
      ),
    );
  }
}