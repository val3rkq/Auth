import 'package:auth/helpers/display_message.dart';
import 'package:auth/helpers/scroll_down.dart';
import 'package:auth/widgets/exporters/login_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // get AUTH instance
  FirebaseAuth _auth = FirebaseAuth.instance;

  // controllers
  TextEditingController emailController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      displayMessage(context, 'Password reset link sent! Check your email');
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      displayMessage(context, 'Error $e');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Forgot password?',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // EMAIL TEXTFIELD
              MyTextField(
                hintText: 'Email',
                controller: emailController,
                onTap: null,
              ),

              SizedBox(
                height: 20,
              ),

              // BUTTON
              MyButton(
                text: 'Reset password',
                onTap: resetPassword,
              )
            ],
          ),
        ));
  }
}
