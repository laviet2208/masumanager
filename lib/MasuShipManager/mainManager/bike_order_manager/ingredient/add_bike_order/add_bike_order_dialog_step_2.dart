import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/areaData/Area.dart';
import 'package:masumanager/MasuShipManager/Data/costData/Cost.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/add_bike_order/add_bike_order_controller.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/add_bike_order/add_bike_order_dialog_step_3.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/add_bike_order/location_item.dart';
import '../../../../../dataClass/FinalClass.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/accountData/userAccount.dart';
import '../../../../Data/models/area_search/search_page_area.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';
import '../../../catch_order_manager/action/add_catch_order/location_pick_in_map.dart';

class add_bike_order_dialog_step_2 extends StatefulWidget {
  final List<Location> peopleLocation;
  final List<Location> bikeLocation;
  const add_bike_order_dialog_step_2({super.key, required this.peopleLocation, required this.bikeLocation});

  @override
  State<add_bike_order_dialog_step_2> createState() => _add_bike_order_dialog_step_2State();
}

class _add_bike_order_dialog_step_2State extends State<add_bike_order_dialog_step_2> {
  final CusNameControl = TextEditingController();
  final CusPhoneControl = TextEditingController();
  Area area = Area(id: '', name: '', money: 0, status: 0);
  bool loading = false;

  motherOrder order = motherOrder(
      id: '',
      locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
      locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
      cost: 0,
      owner: UserAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),),
      shipper: shipperAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), onlineStatus: 0, money: 0, license: '', orderHaveStatus: 0, debt: 0),
      status: 'UC',
      voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
      orderList: [],
      createTime: getCurrentTime()
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text('Thêm đơn lái xe hộ', style: TextStyle(color: Colors.black, fontFamily: 'muli'),),
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
                    fontFamily: 'muli',
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
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên khách hàng',
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
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số điện thoại khách hàng *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số điện thoại khách hàng',
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
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn điểm bắt đầu *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                'Danh sách điểm trả khách',
                style: TextStyle(
                    fontFamily: 'muli',
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
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.peopleLocation.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: location_item(location: widget.peopleLocation[index], index: index, type: 1, callback: () { setState(() {}); },),
                    );
                  },
                ),
              ),
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Danh sách điểm trả xe',
                style: TextStyle(
                    fontFamily: 'muli',
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
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.bikeLocation.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: location_item(location: widget.bikeLocation[index], index: index, type: 2, callback: () { setState(() {}); },),
                    );
                  },
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
                    fontFamily: 'muli',
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
            if (CusNameControl.text.isNotEmpty && CusPhoneControl.text.isNotEmpty && order.locationSet.latitude != 0 && area.id != '') {
              if (add_bike_order_controller.check_if_fill_all_location(widget.bikeLocation) && add_bike_order_controller.check_if_fill_all_location(widget.peopleLocation)) {
                setState(() {
                  loading = true;
                });
                order.owner.name = CusNameControl.text.toString();
                order.owner.phone = CusPhoneControl.text.toString();
                order.owner.area = area.id;
                Cost costFee = await getBikecostFee(area.id);
                setState(() {
                  loading = false;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return add_bike_order_dialog_step_3(order: order, peopleLocation: widget.peopleLocation, bikeLocation: widget.bikeLocation, costFee: costFee,);
                  },
                );
              }
            }
          },
          child: Text(
            'Thêm đơn hàng',
            style: TextStyle(
                color: Colors.blueAccent
            ),
          ),
        ))
      ],
    );
  }
}
