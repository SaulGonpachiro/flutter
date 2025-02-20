import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final VoidCallback? onTap;  // Usamos VoidCallback para un método sin valor de retorno

  const CustomTextInput({
    Key? key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    required this.controller,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.onTap,  // Agregamos el onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // Usamos el onTap aquí
      child: SizedBox(
        width: 300,
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          onSaved: onSaved,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
