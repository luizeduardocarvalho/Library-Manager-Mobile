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
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });

    print(authData);
    try {
      if(authData.isLogin) {
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
    catch(e) {
      ErrorWidget(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
