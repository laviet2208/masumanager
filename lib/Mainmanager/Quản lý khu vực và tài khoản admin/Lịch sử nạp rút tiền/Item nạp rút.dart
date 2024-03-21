import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:masumanager/dataClass/L%E1%BB%8Bch%20s%E1%BB%AD%20giao%20d%E1%BB%8Bch.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

class Itemnaprutkhuvuc extends StatefulWidget {
  final double width;
  final historyTransaction history;
  final Color color;
  const Itemnaprutkhuvuc({Key? key, required this.width, required this.history, required this.color}) : super(key: key);

  @override
  State<Itemnaprutkhuvuc> createState() => _ItemnaprutkhuvucState();
}

class _ItemnaprutkhuvucState extends State<Itemnaprutkhuvuc> {

  Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(widget.history.receiverId).onValue.listen((event) {
      final dynamic are = event.snapshot.value;
      Area areas = Area.fromJson(are);
      area.name = areas.name;
      area.id = areas.id;
      area.status = areas.status;
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 120,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 240, 240, 240),
            width: 1.0,
          ),
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: widget.width/6 - 1,
            child: Padding(
              padding: EdgeInsets.only(top: 50,bottom: 50, left: 30),
              child: AutoSizeText(
                widget.history.id,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/5-1,
            child:Padding(
              padding: EdgeInsets.only(top: 50,bottom: 50, left: 30, right: 10),
              child: AutoSizeText(
                (widget.history.type == 3) ? ('+ ' + dataCheckManager.getStringNumber(widget.history.money) + 'VNĐ') : ('- ' + dataCheckManager.getStringNumber(widget.history.money) + 'VNĐ'),
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold,
                    color: (widget.history.type == 3) ? Colors.green : Colors.redAccent,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/5-1,
            child:Padding(
              padding: EdgeInsets.only(top: 50,bottom: 50, left: 30),
              child: AutoSizeText(
                widget.history.senderId + ' Admin',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

          Container(
            width: widget.width/5-1,
            child:Padding(
              padding: EdgeInsets.only(top: 50,bottom: 50, left: 30),
              child: AutoSizeText(
                area.name,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 100
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240)
            ),
          ),

        ],
      ),
    );
  }
}
