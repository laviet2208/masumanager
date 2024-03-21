import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../dataClass/bikerRequest.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import 'ITEMdontaixe.dart';

class Danhsachyeucau extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachyeucau({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachyeucau> createState() => _DanhsachyeucauState();
}

class _DanhsachyeucauState extends State<Danhsachyeucau> {
  List<bikeRequest> requestList = [];
  List<bikeRequest> chosenList = [];
  List<Area> areaList1 = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("bikeRequest").onValue.listen((event) {
      requestList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        bikeRequest food= bikeRequest.fromJson(value);
        requestList.add(food);
        chosenList.add(food);
      });
      setState(() {

      });
    });
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList1.clear();
      areaList1.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList1.add(area);
      });
      setState(() {
        if (areaList1.length != 0) {
          chosenArea = areaList1.first;
        }
      });
    });
  }

  TextEditingController searchController = TextEditingController();

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < requestList.length ; i++) {
          chosenList.add(requestList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < requestList.length ; i++) {
          if (requestList.elementAt(i).owner.Area == chosenArea.id) {
            chosenList.add(requestList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = requestList
          .where((account) =>
      account.name.toLowerCase().contains(value.toLowerCase()) || account.phoneNumber.toLowerCase().contains(value.toLowerCase()) || account.cmnd.toLowerCase().contains(value.toLowerCase())  || account.address.toLowerCase().contains(value.toLowerCase())
          || account.owner.name.toLowerCase().contains(value.toLowerCase())  || account.owner.phoneNum.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 500,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'roboto',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm đơn yêu cầu',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'roboto',
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 20,
            right: 10,
            child: Container(
              width: 400,
              height: 40,
              child: DropdownButton<Area>(
                items: areaList1.map((e) => DropdownMenuItem<Area>(
                  value: e,
                  child: Text('Khu vực : ' + e.name),
                )).toList(),
                onChanged: (value) { dropdownCallback(value); },
                value: chosenArea,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: 50,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 250, 255),
                  border: Border.all(
                      width: 1,
                      color: Color.fromARGB(255, 225, 225, 226)
                  )
              ),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: (widget.width - 20)/3 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thông tin tài khoản yêu cầu',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (widget.width - 20)/3 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Chi tiết yêu cầu',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),

                  Container(
                    width: (widget.width - 20)/3 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'roboto',
                              color: Colors.black,
                              fontSize: 100
                          ),
                        )
                    ),
                  ),

                  Container(
                    width: 1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 225, 225, 226)
                    ),
                  ),
                ],
              ),
            ),
          ),


          Positioned(
            top: 135,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 170,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: (chosenList.length == 0) ? Text('Không có yêu cầu nào') : ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return ITEMdontaixe(width: widget.width - 20, height: 120, request: chosenList[index],
                    accept: () {

                    }, color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),
                  );
                },
              ),
            ),
          ),


        ],
      ),
    );
  }
}
