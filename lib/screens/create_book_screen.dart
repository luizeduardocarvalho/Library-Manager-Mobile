import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';
import 'package:library_manager/models/book.dart';
import 'package:library_manager/widgets/book_form.dart';

class CreateBookScreen extends StatefulWidget {
  @override
  _CreateBookScreenState createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {

  bool _isLoading = false;

  Future<void> _handleSubmit(Book bookData) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(bookData.code + '.jpg');

      await ref.putFile(bookData.image);
      final url = await ref.getDownloadURL();

      final newBookData = {
        'name': bookData.name,
        'description': bookData.description,
        'code': bookData.code,
        'image_url': url,
        'is_lent': false,
        'author': bookData.author,
        'history': [{
          'date': Timestamp.now(),
          'lent_by': 'SENAC',
          'lent_to': 'SENAC'
        }]
      };

      await FirebaseFirestore.instance
          .collection('books')
          .doc(bookData.code)
          .set(newBookData);
    }
    catch(e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Add New Book',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: [
          BookForm(_handleSubmit),
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
