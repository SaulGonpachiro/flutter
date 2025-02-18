import 'package:Paw_authority/screens/PetsScreen.dart';
import 'package:flutter/material.dart';
import 'package:Paw_authority/UI/background_image.dart';
import 'package:Paw_authority/screens/screens.dart';
import 'package:Paw_authority/UI/LogoWithTitle.dart';
import 'package:Paw_authority/UI/custom_text_input.dart';
import 'package:Paw_authority/UI/button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    // Imagen de fondo
                    const BackgroundImage(imagen: "huron.png"),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo y título
                            const LogoWithTitle(
                              logoImage: "logo.png",
                              title: "Respect My Paw-thority!",
                            ),
                            const SizedBox(height: 40),

                            // Campo de texto para usuario
                            CustomTextInput(
                              label: "Usuario",
                              hint: "Ingrese su usuario",
                              controller: _userController,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 20),

                            // Campo de texto para contraseña
                            CustomTextInput(
                              label: "Contraseña",
                              hint: "Ingrese su contraseña",
                              isPassword: true,
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 30),

                            // Botón reutilizable
                            CustomButton(
                              text: "ENTRAR",
                              onPressed: () {
                                final user = _userController.text.trim();
                                final password = _passwordController.text.trim();

                                // Aquí puedes manejar las credenciales
                                if (user.isNotEmpty && password.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PetsScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Por favor, complete todos los campos"),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
