import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/widgets/manage_book_form.dart';

class LendScreen extends StatefulWidget {

  @override
  _LendScreenState createState() => _LendScreenState();
}

class _LendScreenState extends State<LendScreen> {

  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  // TODO: Refactor
  Future<void> _handleSubmit(String bookCode, String lentToName) async {
    setState(() {
      _isLoading = true;
    });

    var book = await FirebaseFirestore.instance.collection('books').doc(bookCode).get();
    var user = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.uid).get();

    var bookHistory = book.data()['history'];
    if(bookHistory == null) {
      var borrowHistory = <Map>[];
      borrowHistory.add({
        'date': Timestamp.now(),
        'lent_to': lentToName,
        'lent_by' : user.data()['name'],
      });
      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookCode)
          .update({
        'is_lent': true,
        'history': borrowHistory,
      });
    } else {
      bookHistory.add({
        'date': Timestamp.now(),
        'lent_to': lentToName,
        'lent_by': user.data()['name']
      });
      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookCode)
          .update({
        'is_lent': true,
        'history': bookHistory,
      });
    }

    setState(() {
      _isLoading = true;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Lend Book',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: [
          ManageBookForm(_handleSubmit, true),
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
