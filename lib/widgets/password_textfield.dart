import 'package:auth/helpers/scroll_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key, required this.hintText, required this.controller, required this.onTap});

  final String hintText;
  final TextEditingController controller;
  final Function()? onTap;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
          ),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
