import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';
import 'package:intl/intl.dart';

class BookScreen extends StatefulWidget {

  final bookData;

  BookScreen(this.bookData);

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.bookData['name'],
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: kMenuCardButtonColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start                                                     ,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Image(image: NetworkImage(widget.bookData['image_url'])),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.bookData['code']} - ${widget.bookData['name']}',
                            style: TextStyle(
                              fontSize: 25.0
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            widget.bookData['author'],
                            style: TextStyle(
                              fontSize: 20.0
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(
                            widget.bookData['is_lent'] ? 'Unavailable' : 'Available',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: widget.bookData['is_lent'] ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Text(widget.bookData['description']),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Container(
                      child: ListView.builder(
                        itemCount: widget.bookData['history'].length,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.bookData['history'][widget.bookData['history'].length - 1 - i]['lent_to'],
                                      style: TextStyle(
                                        color: i == 0 ? Colors.red : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.bookData['history'][widget.bookData['history'].length - 1 - i]['lent_by'],
                                      style: TextStyle(
                                        color: i == 0 ? Colors.red : Colors.black,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat().add_yMMMEd().format(widget.bookData['history'][widget.bookData['history'].length - 1 - i]['date'].toDate()).toString(),
                                    style: TextStyle(
                                      color: i == 0 ? Colors.red : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      color: Colors.white,
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
