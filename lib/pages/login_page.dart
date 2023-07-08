import 'package:auth/helpers/display_message.dart';
import 'package:auth/helpers/scroll_down.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth/widgets/exporters/login_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onTap});

  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // get AUTH instance
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  // current user ID
  late String id;

  void signInWithEmail() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      displayMessage(context, 'Error $e');
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'uid': _auth.currentUser!.uid,
        'email': gUser.email,
        'password': '',
        'name': gUser.displayName,
      });
    } on FirebaseAuthException catch (e) {
      displayMessage(context, 'Error $e');
    }
  }

  void signInWithApple() async {

    displayMessage(context, 'Sorry.. But this function is not available. :(');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Welcome back!\nWe are glad to see you here!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 50,
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
                      height: 5,
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot Password?',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // SIGN IN button
                    Center(
                      child: MyButton(
                        text: 'Sign In',
                        onTap: signInWithEmail,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              height: 2,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Text(
                          'or try with',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              height: 2,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),

                // OTHER WAYS OF AUTHENTICATION
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google
                    GestureDetector(
                      onTap: signInWithGoogle,
                      child: OtherAuthContainer(
                        nameOfAuthProvider: 'google',
                      ),
                    ),

                    SizedBox(
                      width: 15,
                    ),

                    // apple
                    GestureDetector(
                      onTap: signInWithApple,
                      child: OtherAuthContainer(
                        nameOfAuthProvider: 'apple',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),

                // GO TO REGISTER PAGE
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
