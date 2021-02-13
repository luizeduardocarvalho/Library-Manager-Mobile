import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';

class MenuCardButton extends StatelessWidget {

  final Function onTap;
  final String buttonText;
  final Color color;

  MenuCardButton({this.onTap, this.buttonText, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color,
        elevation: 3.0,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}