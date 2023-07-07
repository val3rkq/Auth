import 'package:auth/pages/home_page.dart';
import 'package:auth/pages/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ScaffoldMessenger(
            child: SnackBar(
              content: Text('Error ${snapshot.error.toString()}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          // user is logged in
          return const HomePage();
        } else {
          // user is not logged in
          return const LoginOrRegister();
        }
      },
    );
  }
}
