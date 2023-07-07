import 'package:auth/helpers/scroll_down.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.hintText, required this.controller, required this.onTap});

  final String hintText;
  final TextEditingController controller;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
