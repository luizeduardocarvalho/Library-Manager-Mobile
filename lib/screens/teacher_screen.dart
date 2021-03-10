import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/widgets/book_card.dart';

class TeacherScreen extends StatefulWidget {

  final teacherData;

  TeacherScreen(this.teacherData);

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  var books = [];
  var _isLoading = false;

  void getBooks() async {
    setState(() {
      _isLoading = true;
    });

    var bookList = await FirebaseFirestore.instance.collection('books').where('code', whereIn: widget.teacherData['books']).get();
    bookList.docs.forEach((doc) => {
      books.add(doc.data())
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getBooks();
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
          'Teacher\'s Book List',
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
      body: Stack(
        children: [
          if(!_isLoading)
            Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (ctx, i) {
                        return BookCard(
                          books.elementAt(i),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
