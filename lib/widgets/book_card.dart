import 'package:flutter/material.dart';
import 'package:library_manager/screens/book_screen.dart';

class BookCard extends StatelessWidget {

  final book;

  BookCard(this.book);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BookScreen(book))),
      child: Card(
        color: Color(0xFFED891E),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(book['image_url']),
                ),
                SizedBox(width: 10.0,),
                Text(
                  book['name'],
                  style: TextStyle(
                    color: Colors.black
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
