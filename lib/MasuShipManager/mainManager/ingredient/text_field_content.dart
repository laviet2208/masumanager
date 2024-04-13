import 'package:flutter/material.dart';

class text_field_content extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const text_field_content({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              )
          ),

          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Form(
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'muli',
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
