import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';
import 'package:library_manager/widgets/book_card.dart';

class BookListScreen extends StatefulWidget {

  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {

  var bookList;
  dynamic filteredBookList = [];
  String bookName;
  bool _isLoading = false;

  Future<void> getBookList() async {
    setState(() {
      _isLoading = true;
    });

    bookList = await FirebaseFirestore.instance.collection('books').get();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getBookList();
    super.initState();
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
          'Book List',
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
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              bookName = value;
                              filteredBookList = bookList.docs.where((i)
                              {
                                i.data()['name'].toLowerCase().contains(bookName.toLowerCase()));
                              };
                            });
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter book name',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0,),
                Expanded(
                  child: ListView.builder(
                      itemCount: filteredBookList.length,
                      itemBuilder: (ctx, i) {
                        return BookCard(
                          filteredBookList.elementAt(i),
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
