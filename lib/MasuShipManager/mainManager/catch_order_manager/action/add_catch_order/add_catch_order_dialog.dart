import 'package:flutter/material.dart';
import '../../../../Data/models/area_search/search_page_area.dart';
import '../../../../../dataClass/FinalClass.dart';
import '../../../../Data/costData/Cost.dart';
import '../../../../Data/accountData/shipperAccount.dart';
import '../../../../Data/accountData/userAccount.dart';
import '../../../../Data/OrderData/catchOrder.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/voucherData/Voucher.dart';
import 'caculate_order_money_dialog.dart';
import 'location_pick_in_map.dart';

class add_catch_order_dialog extends StatefulWidget {
  const add_catch_order_dialog({Key? key}) : super(key: key);

  @override
  State<add_catch_order_dialog> createState() => _add_catch_order_dialogState();
}

class _add_catch_order_dialogState extends State<add_catch_order_dialog> {
  final CusNameControl = TextEditingController();
  final CusPhoneControl = TextEditingController();
  bool loading = false;
  CatchOrder order = CatchOrder(id: '',
    locationSet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    locationGet: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),
    cost: 0,
    owner: UserAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),),
    shipper: shipperAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', area: '', phone: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), onlineStatus: 0, money: 0, license: '', orderHaveStatus: 0, debt: 0),
    status: 'A',
    voucher: Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 0, CustomList: [], maxSale: 0, area: ''),
    S1time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
    costFee: Cost(departKM: 0, departCost: 0, perKMcost: 0, discount: 0),
    subFee: 0,
  );

  Area area = Area(id: '', name: '', money: 0, status: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              child: location_pick_in_map(location: order.locationSet),
            ),

            Container(
              height: 15,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn điểm trả khách(Không chọn mục này nếu là đơn tự chỉ đường) *',
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
            if (CusNameControl.text.isNotEmpty && CusPhoneControl.text.isNotEmpty && order.locationSet.latitude != 0 && order.locationSet.longitude != 0 && area.id != '') {
              order.id = generateID(25);
              order.shipper.area = area.id;
              order.owner.area = area.id;
              order.owner.name = CusNameControl.text.toString();
              order.owner.phone = CusPhoneControl.text.toString();
              order.S1time = getCurrentTime();
              setState(() {
                loading = true;
              });
              double distance = 0;
              if (order.locationGet.longitude != 0) {
                distance = await getDistance(order.locationSet, order.locationGet);
              }
              setState(() {
                loading = false;
              });
              showDialog(
                context: context,
                builder: (context) {
                  return caculate_order_money_dialog(order: order, distance: distance,);
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
