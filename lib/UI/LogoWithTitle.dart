import 'package:flutter/material.dart';
import 'package:Paw_authority/UI/background_image.dart';

class LogoWithTitle extends StatelessWidget {
  final String logoImage;
  final String title;
  final TextStyle? titleStyle;

  const LogoWithTitle({
    Key? key,
    required this.logoImage,
    required this.title,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: BackgroundImage(imagen: logoImage),
        ),
        const SizedBox(height: 20),

        Text(
          title,
          style: titleStyle ??
              const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
