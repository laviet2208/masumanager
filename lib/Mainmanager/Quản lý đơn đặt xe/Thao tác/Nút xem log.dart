import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BA%B7t%20xe/Data/catchOrder.dart';

import 'Xem log đơn hàng.dart';

class ButtonViewCatchLog extends StatefulWidget {
  final catchOrder order;
  const ButtonViewCatchLog({Key? key, required this.order}) : super(key: key);

  @override
  State<ButtonViewCatchLog> createState() => _ButtonViewCatchLogState();
}

class _ButtonViewCatchLogState extends State<ButtonViewCatchLog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            border: Border.all(
                width: 1,
                color: Colors.yellow.shade700
            )
        ),
        alignment: Alignment.center,
        child: Text(
          'Xem log đơn',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.yellow.shade700
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  width: 500,
                  height: 400,
                  child: ViewLogCatch(thiscatch: widget.order),
                ),
              );
            }
        );
      },
    );
  }
}
