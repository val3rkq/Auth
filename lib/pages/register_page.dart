import 'package:auth/helpers/scroll_down.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth/widgets/exporters/register_widgets.dart';

import '../helpers/display_message.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.onTap});

  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // get AUTH instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  // current user ID
  late String id;

  void signUp() async {
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
          'uid': _auth.currentUser!.uid,
          'email': emailController.text,
          'password': passwordController.text,
          'name': nameController.text,
        });

        id = _auth.currentUser!.uid;
      } else {
        displayMessage(context, 'Passwords are different');
      }
    } on FirebaseAuthException catch (e) {
      displayMessage(context, 'Error $e');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                // APP LOGO
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Application Logo',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.api_rounded,
                      size: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),

                // TEXTFIELDS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // some text
                    Text(
                      "Welcome! \nLet's create an account for you!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    // NAME TEXTFIELD
                    MyTextField(
                      hintText: 'Your Name',
                      controller: nameController,
                      onTap: () => scrollDown(_scrollController),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // EMAIL TEXTFIELD
                    MyTextField(
                      hintText: 'Email',
                      controller: emailController,
                      onTap: () => scrollDown(_scrollController),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // PASSWORD TEXTFIELD
                    PasswordTextField(
                      hintText: 'Password',
                      controller: passwordController,
                      onTap: () => scrollDown(_scrollController),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    // CONFIRM PASSWORD TEXTFIELD
                    PasswordTextField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      onTap: () => scrollDown(_scrollController),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    // SIGN IN button
                    Center(
                      child: MyButton(
                        text: 'Sign Up',
                        onTap: signUp,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),

                // GO TO LOGIN PAGE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
