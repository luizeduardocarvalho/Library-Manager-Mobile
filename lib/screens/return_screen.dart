import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/widgets/manage_book_form.dart';

class ReturnScreen extends StatelessWidget {

  Future<void> _handleSubmit(bookCode, lentToName) async {
    await FirebaseFirestore.instance
        .collection('books')
        .doc(bookCode)
        .update({
      'is_lent': false,
    });
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
        ],
      ),
    );
  }
}
