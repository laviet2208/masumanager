import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/configuration_manager.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/recharge_admin_money.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/withdraw_admin_money.dart';
import 'package:masumanager/dataClass/adminaccount.dart';
import '../../Data/areaData/Area.dart';

class area_item extends StatefulWidget {
  final Area area;
  final int index;
  const area_item({Key? key, required this.area, required this.index}) : super(key: key);

  @override
  State<area_item> createState() => _area_itemState();
}

class _area_itemState extends State<area_item> {
  List<AdminAccount> adminList = [];

  void get_admin_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("ADMINaccount").onValue.listen((event) {
      adminList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        AdminAccount adminAccount = AdminAccount.fromJson(value);
        if (adminAccount.provinceCode == widget.area.id) {
          adminList.add(adminAccount);
        }
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_admin_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: (widget.index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
              width: 1,
              color: Colors.grey
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: (width)/5 - 1,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(
                widget.area.id,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16
                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width)/5 - 1,
            alignment: Alignment.center,
            child:Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(
                widget.area.name,
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    color: Colors.purple,
                    fontSize: 16
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
            width: (width)/5 - 1,
            alignment: Alignment.center,
            child:Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(
                getStringNumber(widget.area.money) + ' VNĐ',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16
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
            width: (width)/5 - 1,
            alignment: Alignment.center,
            child:Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Text(
                adminList.length.toString() + ' Tài khoản',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 16
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
            width: width/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(height: 4,),

                  withdraw_admin_money(area: widget.area),

                  Container(height: 4,),

                  recharge_admin_money(area: widget.area),

                  Container(height: 4,),

                  GestureDetector(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black,
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Cấu hình khu vực',
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: configuration_manager(id: widget.area.id),
                          );
                        },
                      );
                    },
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
