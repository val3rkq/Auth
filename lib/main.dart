import 'package:auth/auth.dart';
import 'package:auth/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.bebasNeue(
            fontSize: 25,
            color: Colors.black
          )
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.deepPurple,
          secondary: Colors.grey.shade800,
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.bebasNeue(fontSize: 27, fontWeight: FontWeight.w500, color: Colors.grey.shade800),
          bodyMedium: GoogleFonts.bebasNeue(fontSize: 20, color: Colors.grey.shade200),
          bodySmall: GoogleFonts.bebasNeue(fontSize: 20, color: Colors.black),
          bodyLarge: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.black),
          displaySmall: GoogleFonts.bebasNeue(fontSize: 17)
        ),
      ),
      home: const AuthGate(),
    );
  }
}
