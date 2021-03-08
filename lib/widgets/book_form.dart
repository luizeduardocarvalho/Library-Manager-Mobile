import 'dart:io';

import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';
import 'package:library_manager/models/book.dart';
import 'package:library_manager/widgets/book_image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class BookForm extends StatefulWidget {

  final Function(Book bookData) onSubmit;

  BookForm(this.onSubmit);

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {

  Book _book = Book();

  void _submit() {
    FocusScope.of(context).unfocus();
    widget.onSubmit(_book);
  }

  void _handlePickedImage(File pickedImage) {
    _book.image = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: kMenuCardButtonColor,
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                if(!kIsWeb)
                BookImagePicker(_handlePickedImage),
                TextField(
                  key: ValueKey('code'),
                  decoration: kInputFieldDecoration.copyWith(
                    labelText: 'Code'
                  ),
                  onChanged: (value) => _book.code = value,
                ),
                TextFormField(
                    key: ValueKey('name'),
                    initialValue: _book.name,
                    decoration: kInputFieldDecoration.copyWith(
                      labelText: 'Name'
                    ),
                    onChanged: (value) => _book.name = value,
                  ),
                TextFormField(
                  key: ValueKey('description'),
                  initialValue: _book.description,
                  decoration: kInputFieldDecoration.copyWith(
                    labelText: 'Description'
                  ),
                  onChanged: (value) => _book.description = value,
                ),
                TextFormField(
                  key: ValueKey('author'),
                  initialValue: _book.author,
                  decoration: kInputFieldDecoration.copyWith(
                      labelText: 'Author'
                  ),
                  onChanged: (value) => _book.author = value,
                ),
                SizedBox(height: 12.0,),
                RaisedButton(
                  color: Color(0xFF155595),
                  onPressed: _submit,
                  child: Text(
                    'Add Book',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
