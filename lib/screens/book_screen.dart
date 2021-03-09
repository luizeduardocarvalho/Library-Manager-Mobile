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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(widget.bookData['image_url'] != null)
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Image(image: NetworkImage(widget.bookData['image_url'])),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                            child: Text(
                              '${widget.bookData['code']} - ${widget.bookData['name']}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.bookData['author'],
                              style: TextStyle(
                                fontSize: 20.0
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.bookData['is_lent'] ? 'Unavailable' : 'Available',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: widget.bookData['is_lent'] ? Colors.red[800] : Colors.green[800],
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Student',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0,),
                              Expanded(
                                child: Text(
                                  'Teacher',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0,),
                              Expanded(
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Container(
                           child: ListView.builder(
                             itemCount: widget.bookData['history'].length,
                             itemBuilder: (ctx, i) {
                               return Container(
                                 padding: EdgeInsets.all(10.0),
                                 child: Row(
                                   children: [
                                     Expanded(
                                       child: Text(
                                         widget.bookData['history'][widget.bookData['history'].length - 1 - i]['lent_to'],
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 12.0,
                                         ),
                                       ),
                                     ),
                                     SizedBox(width: 5.0,),
                                     Expanded(
                                       child: Text(
                                         widget.bookData['history'][widget.bookData['history'].length - 1 - i]['lent_by'],
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 12.0,
                                         ),
                                       ),
                                     ),
                                     SizedBox(width: 5.0,),
                                     Expanded(
                                       child: Text(
                                         DateFormat().add_yMMMEd().format(widget.bookData['history'][widget.bookData['history'].length - 1 - i]['date'].toDate()).toString(),
                                         style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 12.0,
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               );
                             },
                           ),
                            color: Colors.white,
                          ),
                        ),
                      ],
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
