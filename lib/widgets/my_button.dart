import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, this.onTap});

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}