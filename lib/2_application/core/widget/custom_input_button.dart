import 'package:flutter/material.dart';

class CustomInputButton extends StatelessWidget {
  final String title;
  final Widget prefixIconUrl;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;

  const CustomInputButton({super.key, 
    
    required this.title,
    required this.prefixIconUrl,
    required this.obscureText,
    required this.textInputType,
    required this.controller, String? errorText,
  }) ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        labelText: title,
        labelStyle: const TextStyle(
          color: Color(0xFFADA4A5),
          fontSize: 14.0,
        ),
        prefixIcon: prefixIconUrl,
      ),
    );
  }
}