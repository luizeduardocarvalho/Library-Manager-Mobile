import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_manager/widgets/book_card.dart';
import 'package:library_manager/widgets/teacher_card.dart';

class TeachersScreen extends StatefulWidget {

  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {

  var teacherList;
  bool _isLoading = false;

  Future<void> getTeacherList() async {
    setState(() {
      _isLoading = true;
    });

    teacherList = await FirebaseFirestore.instance.collection('teachers').get();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getTeacherList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Teacher List',
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
                  SizedBox(height: 8.0,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: teacherList.docs.length,
                      itemBuilder: (ctx, i) {
                        return TeacherCard(
                          teacherList.docs[i].data(),
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
