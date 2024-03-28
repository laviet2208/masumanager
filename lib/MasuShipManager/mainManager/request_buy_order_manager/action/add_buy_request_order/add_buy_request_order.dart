import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import '../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../request_buy_order_manager/action/add_buy_request_order/view_product_list.dart';
import '../../../../../dataClass/FinalClass.dart';
import '../../../../Data/costData/Cost.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/accountData/userAccount.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/models/area_search/search_page_area.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../catch_order_manager/action/add_catch_order/location_pick_in_map.dart';
import '../caculate_free_request_order_money/caculate_free_request_order_money_dialog.dart';

class add_buy_request_order extends StatefulWidget {
  const add_buy_request_order({Key? key,}) : super(key: key);

  @override
  State<add_buy_request_order> createState() => _add_buy_request_orderState();
}

class _add_buy_request_orderState extends State<add_buy_request_order> {
  bool loading = false;
  final CusNameControl = TextEditingController();
  final ResNameControl = TextEditingController();
  final CusPhoneControl = TextEditingController();
  final ResPhoneControl = TextEditingController();
  String totalText = 'Chưa có mặt hàng';
  Area area = Area(id: '', name: '', money: 0, status: 0);

  requestBuyOrder order = requestBuyOrder(id: '', locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), cost: 0, owner: UserAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),), shipper: shipperAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), onlineStatus: 0, money: 0, license: '', orderHaveStatus: 0), status: 'A', voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''), S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0), productList: [], shop: ShopAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', phone: '', type: 0, password: '', closeTime: getCurrentTime(), openTime: getCurrentTime(), openStatus: 0, area: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), listDirectory: [], discount_type: 0, money: 0),);

  //Hàm tổng hợp các mặt hàng
  String get_product_total() {
    double totalMoney = 0;
    for(int i = 0 ; i < order.productList.length; i++){
      totalMoney = totalMoney + (order.productList[i].number * order.productList[i].cost);
    }

    return 'Tổng cộng: ' + order.productList.length.toStringAsFixed(0) + ' mặt hàng, ' + getStringNumber(totalMoney) + 'Vnđ';
  }

  //Hàm lấy thông tin phí dịch vụ
  Future<Cost> get_buy_request_cost() async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('CostFee/' + order.shipper.area + '/BuyRequestCost').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      Cost cost = Cost.fromJson(catchOrderData);
      return cost;
    }
    return Cost(departKM: 2, departCost: 2, perKMcost: 2, discount: 2);
  }

  //Hàm lấy khoảng cách
  Future<double> getDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) async {
    final url = Uri.parse("https://rsapi.goong.io/DistanceMatrix?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&vehicle=bike&api_key=3u7W0CAOa9hi3SLC6RI3JWfBf6k8uZCSUTCHKOLf");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final distance = data['rows'][0]['elements'][0]['distance']['value'];
        return distance.toDouble()/1000;
      } else {
        throw Exception('Lỗi khi gửi yêu cầu tới Goong API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi xử lý dữ liệu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text('Thêm đơn tự do', style: TextStyle(color: Colors.black, fontFamily: 'arial'),),
      content: Container(
        width: width/3,
        height: height/1.2,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Thông tin khách hàng',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

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
                'Chọn điểm giao hàng *',
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
              child: location_pick_in_map(location: order.locationGet),
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Thông tin cửa hàng',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên cửa hàng *',
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
                        controller: ResNameControl,
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
                'Số điện thoại cửa hàng *',
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
                        controller: ResPhoneControl,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập sđt khách hàng',
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
                'Chọn địa chỉ nhà hàng *',
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
              child: location_pick_in_map(location: order.locationSet),
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Thông tin sản phẩm *',
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
                height: 35,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: width/12,
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent.shade700,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Thay đổi',
                          style: TextStyle(
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return view_product_list(order: order, event: () {setState(() {totalText = get_product_total();});});
                          },
                        );
                      },
                    ),

                    Container(width: 10,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        totalText,
                        style: TextStyle(
                          fontFamily: 'arial',
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                child: search_page_area(area: area,),
              ),
            ),

            Container(height: 20,),
          ],
        ),
      ),
      actions: <Widget>[
        (loading ? CircularProgressIndicator(color: Colors.black,) : TextButton(
          onPressed: () async {
            if (CusNameControl.text.isNotEmpty && CusPhoneControl.text.isNotEmpty && ResNameControl.text.isNotEmpty && ResPhoneControl.text.isNotEmpty && order.locationSet.latitude != 0 && order.locationGet.latitude != 0 && order.locationSet.longitude != 0 && order.locationGet.longitude != 0 && area.id != '' && order.productList.length != 0) {
              order.id = generateID(15);
              order.shipper.area = area.id;
              order.owner.area = area.id;
              order.owner.name = CusNameControl.text.toString();
              order.owner.phone = CusPhoneControl.text.toString();
              order.shop.name = ResNameControl.text.toString();
              order.shop.phone = ResPhoneControl.text.toString();
              order.S1time = getCurrentTime();
              order.costFee = await get_buy_request_cost();
              setState(() {
                loading = true;
              });
              double distance = await getDistance(order.locationSet.latitude, order.locationSet.longitude, order.locationGet.latitude, order.locationGet.longitude);
              setState(() {
                loading = false;
              });
              showDialog(
                context: context,
                builder: (context) {
                  return caculate_free_request_order_money_dialog(order: order, distance: distance,);
                },
              );
            } else {
              toastMessage('Vui lòng điền đủ thông tin');
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
