import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import 'autocomplate_prediction.dart';

class ITEMplaceAutoComplete extends StatefulWidget {
  final AutocompletePrediction location;
  final double width;
  final bool loading;
  final VoidCallback onTap;
  const ITEMplaceAutoComplete({Key? key, required this.location, required this.width, required this.onTap, required this.loading}) : super(key: key);

  @override
  State<ITEMplaceAutoComplete> createState() => _ITEMplaceAutoCompleteState();
}

class _ITEMplaceAutoCompleteState extends State<ITEMplaceAutoComplete> {
  String secondaryText = 'Dont have a secondary Text';
  @override
  Widget build(BuildContext context) {
    if (widget.location.structuredFormatting!.secondaryText.toString() != null || widget.location.structuredFormatting!.secondaryText.toString().isNotEmpty ) {
      secondaryText = widget.location.structuredFormatting!.secondaryText.toString();
    }
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: 80,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: (80-30)/2,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/locationRounditem.png'),
                  ),
                ),
              ),
            ),

            Positioned(
              right: 10,
              top: (80-15)/2,
              child: Container(
                width: 15,
                height: 15,
                child: widget.loading ? CircularProgressIndicator(color: Colors.yellow.shade600,) : Icon(Icons.chevron_right, color: Colors.black,),
              ),
            ),


            Positioned(
              top: 19,
              left: 40,
              child: Text(
                dataCheckManager.limitString(widget.location.description.toString(),30),
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              top: 44,
              left: 40,
              child: Text(
                dataCheckManager.limitString(secondaryText,40),
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: Container(
                width: widget.width-40,
                height: 3,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
