import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/add_bike_order/add_bike_order_dialog_step_2.dart';

import '../../../../Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/accountData/userAccount.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';

class add_bike_order_dialog_step_1 extends StatefulWidget {
  const add_bike_order_dialog_step_1({super.key});

  @override
  State<add_bike_order_dialog_step_1> createState() => _add_bike_order_dialog_step_1State();
}

class _add_bike_order_dialog_step_1State extends State<add_bike_order_dialog_step_1> {
  List<Location> peopleLocation = [];
  List<Location> bikeLocation = [];
  final peopleController = TextEditingController();
  final bikeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3;
    double height = MediaQuery.of(context).size.height/2;
    return AlertDialog(
      title: Text('Chọn số lượng', style: TextStyle(color: Colors.black, fontFamily: 'muli'),),
      content: Container(
        height: 150,
        width: width,
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

        child: ListView(
          children: [
            Container(
              height: 10,
            ),

            Padding(
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
                        controller: peopleController,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))], // Chỉ cho phép nhập số
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số lượng khách hàng',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 10,
            ),

            Padding(
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
                        controller: bikeController,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))], // Chỉ cho phép nhập số
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số lượng xe',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            peopleLocation.clear();
            bikeLocation.clear();
            if (peopleController.text.isNotEmpty && bikeController.text.isNotEmpty) {
              for (int i = 0; i < int.parse(peopleController.text.toString()); i++) {
                Location location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
                peopleLocation.add(location);
              }
              for (int i = 0; i < int.parse(bikeController.text.toString()); i++) {
                Location location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
                bikeLocation.add(location);
              }
              showDialog(
                context: context,
                builder: (context) {
                  return add_bike_order_dialog_step_2(peopleLocation: peopleLocation, bikeLocation: bikeLocation);
                },
              );
            } else {
              toastMessage('Bạn chưa nhập thông tin');
            }

          },
          child: Text(
            'Tiếp tục',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
