import 'package:flutter/material.dart';
import 'package:library_manager/screens/teacher_screen.dart';

class TeacherCard extends StatelessWidget {

  final teacher;

  TeacherCard(this.teacher);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherScreen(teacher))),
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
                  SizedBox(width: 10.0,),
                Text(
                  teacher['name'],
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
