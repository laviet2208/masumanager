import 'package:flutter/material.dart';

class text_field_title extends StatelessWidget {
  final String title;
  const text_field_title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'muli',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),
      ),
    );
  }
}
