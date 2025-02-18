import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String imagen;
  const BackgroundImage({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Image.asset(
      "assets/images/${imagen}",
      fit: BoxFit.cover,
    ));
  }
}
