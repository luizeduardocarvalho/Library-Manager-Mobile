import 'dart:core';
import 'dart:io';

class Book {
  String author;
  String code;
  String name;
  String description;
  File image;
  String imageUrl;
  bool isLent;
  DateTime lendDate;
  String lentTo;
  String lentBy;

  void toggleLentStatus() {
    isLent = !isLent;
  }
}