import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/area_item.dart';
import '../../Data/costData/Cost.dart';
import '../../Data/areaData/Area.dart';
import '../../Data/otherData/utils.dart';

class area_manager_page extends StatefulWidget {
  const area_manager_page({Key? key}) : super(key: key);

  @override
  State<area_manager_page> createState() => _area_manager_pageState();
}

class _area_manager_pageState extends State<area_manager_page> {
  bool loading = false;
  final tenkhuvuccontrol = TextEditingController();
  final List<Area> areaList = [];

  void get_area_list() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area food= Area.fromJson(value);
        areaList.add(food);
      });
      setState(() {

      });
    });
  }

  Future<void> push_area_data(Area area) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Area').child(area.id).set(area.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm khu vực thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> push_fee_data(String id, String type) async{
    try {
      Cost cost = Cost(departKM: 4, departCost: 15000, milestoneKM1: 15, milestoneKM2: 10, perKMcost1: 6000, perKMcost2: 7000, perKMcost3: 8000, discountLimit: 20000, discountMoney: 3000, discountPercent: 20);
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('CostFee/' + id).child(type).set(cost.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm khu vực thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_list();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 80;
    double height = MediaQuery.of(context).size.height - 60;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 0,
            child: GestureDetector(
              child: Container(
                width: 240,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(0)
                ),
                child: Text(
                  '+ Thêm khu vực mới',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () {
                showDialog (
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Thêm khu vực mới'),
                      content: Container(
                        width: MediaQuery.of(context).size.width/3, // Đặt kích thước chiều rộng theo ý muốn
                        height: MediaQuery.of(context).size.height/3, // Đặt kích thước chiều cao theo ý muốn
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2), // màu của shadow
                              spreadRadius: 5, // bán kính của shadow
                              blurRadius: 7, // độ mờ của shadow
                              offset: Offset(0, 3), // vị trí của shadow
                            ),
                          ],
                        ),

                        child: ListView(
                          children: [
                            Container(
                              height: 10,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Tên khu vực mới *',
                                style: TextStyle(
                                    fontFamily: 'arial',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent
                                ),
                              ),
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
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black,
                                      )
                                  ),

                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Form(
                                      child: TextFormField(
                                        controller: tenkhuvuccontrol,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'arial',
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Tên khu vực mới',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: 'arial',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ),

                            Container(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Hủy'),
                          onPressed: () async {
                            tenkhuvuccontrol.clear();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: loading ? CircularProgressIndicator() : Text('Lưu'),
                          onPressed: loading ? null : () async {
                            setState(() {
                              loading = true;
                            });

                            if (tenkhuvuccontrol.text.isNotEmpty) {
                              Area newArea = Area(id: generateID(20), name: tenkhuvuccontrol.text.toString(), money: 0, status: 0);
                              await push_fee_data(newArea.id, 'bikeShipCost');
                              await push_fee_data(newArea.id, 'expressShipCost');
                              await push_fee_data(newArea.id, 'requestBuyShipCost');
                              await push_fee_data(newArea.id, 'foodShipCost');
                              await push_area_data(newArea);
                              setState(() {
                                loading = false;
                              });

                              tenkhuvuccontrol.clear();
                              Navigator.of(context).pop();
                            } else {
                              toastMessage('Phải nhập đủ thông tin');
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          Positioned(
            top: 80,
            left: 0,
            child: Container(
              width: width,
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
                    width: (width)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'ID khu vực kinh doanh',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'muli',
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
                    width: (width)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tên khu vực kinh doanh',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'muli',
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
                    width: (width)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Số dư khu vực (đồng)',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'muli',
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
                    width: (width)/5 - 1,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Số lượng Admin',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'muli',
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
                    width: (width)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'muli',
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
            top: 130,
            left: 0,
            right: 0,
            bottom: 10,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              child: ListView.builder(
                itemCount: areaList.length,
                itemBuilder: (context, index) {
                  return area_item(area: areaList[index], index: index,);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
