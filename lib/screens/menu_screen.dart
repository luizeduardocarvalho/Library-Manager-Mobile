import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';
import 'package:library_manager/screens/book_list_screen.dart';
import 'package:library_manager/screens/create_book_screen.dart';
import 'package:library_manager/screens/lend_screen.dart';
import 'package:library_manager/screens/return_screen.dart';
import 'package:library_manager/widgets/menu_card_button.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          )
        ],
        backgroundColor: kBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MenuCardButton(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBookScreen())),
                    buttonText: 'Add New Book',
                    color: kMenuCardButtonColor,
                  ),
                  MenuCardButton(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookListScreen())),
                    buttonText: 'Book List',
                    color: kMenuCardButtonColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MenuCardButton(
                    onTap: null,
                    buttonText: 'Students',
                    color: Color(0xFFA6A6A6),
                  ),
                  MenuCardButton(
                    onTap: null,
                    buttonText: 'Teachers',
                    color: Color(0xFFA6A6A6),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MenuCardButton(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LendScreen())),
                    buttonText: 'Lend Book',
                    color: kMenuCardButtonColor,
                  ),
                  MenuCardButton(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReturnScreen())),
                    buttonText: 'Return Book',
                    color: kMenuCardButtonColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
