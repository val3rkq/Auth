import 'package:flutter/material.dart';

class OtherAuthContainer extends StatelessWidget {
  const OtherAuthContainer({super.key, required this.nameOfAuthProvider});

  final String nameOfAuthProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade300,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Image.asset('assets/$nameOfAuthProvider.png'),
      );
  }
}
