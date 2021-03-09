import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/models/auth_data.dart';
import 'package:library_manager/widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _isLoading = false;
  UserCredential result;

  Future<void> _handleSubmit(AuthData authData) async {
    var errorMessage;
    setState(() {
      _isLoading = true;
    });
    if((authData.isLogin && authData.email != null && authData.password != null) || (authData.isRegister && authData.name != null && authData.email != null && authData.password != null)) {
      try {
        if (authData.isLogin) {
          await _auth.signInWithEmailAndPassword(
              email: authData.email.trim(),
              password: authData.password);
        } else {
          await _auth.createUserWithEmailAndPassword(
              email: authData.email.trim(),
              password: authData.password);

          final userData = {
            'name': authData.name,
            'email': authData.email,
          };

          await FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser.uid)
              .set(userData);
        }
      }
      on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == "user-not-found") {
          errorMessage = "User not found!";
        } else if (e.code == "wrong-password") {
          errorMessage = "Wrong password.";
        } else if (e.code == "invalid-email") {
          errorMessage = "Please enter a valid email.";
        } else if (e.code == "weak-password") {
          errorMessage = "Please enter a password with 8 or more digits.";
        } else {
          errorMessage =
          "The server can't make your request right now, please try again later! :(";
        }
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(
            errorMessage,
          ),
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    // TODO: refactor
    } else {
      errorMessage = "Please fill all fields.";
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text(
          errorMessage,
        ),
      ));

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Library Manager',
                style: TextStyle(
                  fontSize: 30.0
                ),
              ),
              AuthForm(_handleSubmit),
            ],
          ),
          if(_isLoading)
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5)
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
