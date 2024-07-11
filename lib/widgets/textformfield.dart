import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';

class TextformfieldWidget extends StatelessWidget {
  const TextformfieldWidget({required this.hintText, required this.onPress});

  final String hintText;
  final String? Function(String?) onPress;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onPress,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
