import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/widgets/manage_book_form.dart';

class ReturnScreen extends StatefulWidget {

  @override
  _ReturnScreenState createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  Future<void> _handleSubmit(bookCode, lentToName) async {
    setState(() {
      _isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection('books')
        .doc(bookCode)
        .update({
      'is_lent': false,
    });

    var teacher = await FirebaseFirestore.instance
        .collection('teachers')
        .where('user_id', isEqualTo: _auth.currentUser.uid)
        .get();

    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacher.docs[0].id)
        .update({
      'books': FieldValue.arrayRemove([bookCode.toString()])
    });

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Return Book',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: [
          ManageBookForm(_handleSubmit, false),
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
