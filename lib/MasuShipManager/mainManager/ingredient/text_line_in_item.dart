import 'package:flutter/material.dart';

class text_line_in_item extends StatelessWidget {
  final String title;
  final String content;
  const text_line_in_item({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'muli',
                fontWeight: FontWeight.bold,
              ),
            ),

            TextSpan(
              text: content,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'muli',
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
