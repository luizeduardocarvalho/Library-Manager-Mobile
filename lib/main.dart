import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/screens/auth_screen.dart';
import 'package:library_manager/screens/menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Montserrat',
            backgroundColor: Color(0xff0B0A07),
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, userSnapshot) {
              if(userSnapshot.hasData) {
                return MenuScreen();
              } else {
                return AuthScreen();
              }
            },
          ),
          // routes: {
          //   //'/': (context) => MenuScreen(),
          //   '/create-new-book': (context) => CreateBookScreen(),
          //   '/book-list': (context) => BookListScreen(),
          //   '/lend-book': (context) => LendScreen(),
          //   '/return-book': (context) => ReturnScreen(),
          //   '/login': (context) => AuthScreen(),
          // },
        );
      }
    );
  }
}