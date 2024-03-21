import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BA%B7t%20xe/Data/catchOrder.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20%C4%91%C6%A1n%20%C4%91%E1%BA%B7t%20xe/T%E1%BA%A1o%20%C4%91%C6%A1n%20m%E1%BB%9Bi/T%C3%ADnh%20ti%E1%BB%81n%20%C4%91%C6%A1n.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20kh%C3%A1ch%20h%C3%A0ng/accountLocation.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20kh%C3%A1ch%20h%C3%A0ng/accountNormal.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20voucher/Voucher.dart';
import 'package:masumanager/dataClass/Time.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/utils/utils.dart';
import '../../../dataClass/FinalClass.dart';
import '../../Quản lý cấu hình/Cost.dart';
import '../../Quản lý khu vực và tài khoản admin/Area.dart';
import '../../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import '../Chọn vị trí trên map/Chọn vị trí trên map.dart';
import 'package:http/http.dart' as http;


class DialogAddcatchOrder extends StatefulWidget {
  const DialogAddcatchOrder({Key? key}) : super(key: key);

  @override
  State<DialogAddcatchOrder> createState() => _DialogAddcatchOrderState();
}

class _DialogAddcatchOrderState extends State<DialogAddcatchOrder> {
  final CusNameControl = TextEditingController();
  final CusPhoneControl = TextEditingController();
  bool loading = false;
  final catchOrder newOrder = catchOrder(id: dataCheckManager.generateRandomString(15), locationSet: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), locationGet: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), cost: 0, owner: accountNormal(id: '', avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 0, name: '', phoneNum: '', type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), voucherList: [], totalMoney: 0, Area: '', license: '', WorkStatus: 0), shipper: accountNormal(id: 'NA', avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), status: 0, name: '', phoneNum: '', type: 0, locationHis: accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: ''), voucherList: [], totalMoney: 0, Area: '', license: '', WorkStatus: 0), status: 'A', S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), type: 0, voucher: Voucher(id: '', totalmoney: 0, mincost: 0, startTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), endTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), useCount: 0, maxCount: 0, tenchuongtrinh: '', LocationId: '', type: 1, Otype: '', perCustom: 0, CustomList: [], maxSale: 0), costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0));

  List<Area> areaList = [];

  Area area = Area(id: '', name: '', money: 0, status: 0);

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {

      });
    });
  }

  Future<double> getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    final url = Uri.parse("https://rsapi.goong.io/DistanceMatrix?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&vehicle=bike&api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf");


    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final distance = data['rows'][0]['elements'][0]['distance']['value'];
        // Khoảng cách được trả về ở đơn vị mét, bạn có thể chuyển đổi thành đơn vị khác nếu cần.
        return distance.toDouble()/1000;
      } else {
        throw Exception('Lỗi khi gửi yêu cầu tới Goong API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text('Thêm đơn đặt xe', style: TextStyle(color: Colors.black, fontFamily: 'arial'),),
      content: Container(
        width: width/3,
        height: height/1.5,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên khách hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
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
                        controller: CusNameControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên khách hàng',
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
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số điện thoại khách hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
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
                        controller: CusPhoneControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số điện thoại khách hàng',
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
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn điểm đón khách *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: PickLocationInMap(location: newOrder.locationSet, width: width/4 - 20)
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn điểm trả khách *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: 7,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: PickLocationInMap(location: newOrder.locationGet, width: width/4 - 20)
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn khu vực quản lý *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: currentAccount.provinceCode == '0' ? 14 : 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ),

            Container(
              height: currentAccount.provinceCode == '0' ? 10 : 0,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: currentAccount.provinceCode == '0' ? 150 : 0,
                child: searchPageArea(list: areaList, area: area,),
              ),
            ),

            Container(height: 20,),
          ],
        ),
      ),
      actions: <Widget>[
        (loading ? CircularProgressIndicator(color: Colors.black,) : TextButton(
          onPressed: () async {
            if (CusNameControl.text.isNotEmpty && CusPhoneControl.text.isNotEmpty && newOrder.locationSet.Latitude != 0 && newOrder.locationGet.Latitude != 0 && newOrder.locationSet.Longitude != 0 && newOrder.locationGet.Longitude != 0 && area.id != '') {
              newOrder.shipper.Area = area.id;
              newOrder.owner.Area = area.id;
              newOrder.owner.name = CusNameControl.text.toString();
              newOrder.owner.phoneNum = CusPhoneControl.text.toString();
              newOrder.S1time = getCurrentTime();
              setState(() {
                loading = true;
              });
              double distance = await getDistance(newOrder.locationSet.Latitude, newOrder.locationSet.Longitude, newOrder.locationGet.Latitude, newOrder.locationGet.Longitude);
              setState(() {
                loading = false;
              });
              showDialog(
                context: context,
                builder: (context) {
                  return CaculateCatchOrder(order: newOrder, distance: distance);
                },
              );
            }

          },
          child: Text(
            'Thêm đơn hàng',
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ))
      ],
    );
  }
}
