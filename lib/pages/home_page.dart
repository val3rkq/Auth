import 'package:auth/helpers/display_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get AUTH and Firestore instance
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user ID
  late String currentUserID;

  void signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // HELLO USER
          StreamBuilder(
            stream: _firestore
                .collection('users')
                .doc(_auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                displayMessage(context, "Error ${snapshot.error}");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var user = snapshot.data!.data() as Map<String, dynamic>;
              String username = user['name'];
              return Center(
                child: Text(
                  'Hello\n$username',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),

          SizedBox(
            height: 100,
          ),
          //  SIGN OUT
          GestureDetector(
            onTap: signOut,
            child: Icon(
              Icons.logout_rounded,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
