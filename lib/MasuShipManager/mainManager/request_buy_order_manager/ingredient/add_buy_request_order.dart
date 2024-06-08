import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/request_buy_order_manager/controller/start_request_order_controller.dart';
import '../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../Data/otherData/utils.dart';
import '../../ingredient/search_location_dialog.dart';
import '../../../../dataClass/FinalClass.dart';
import '../../../Data/costData/Cost.dart';
import '../../../Data/accountData/shipperAccount.dart';
import '../../../Data/accountData/userAccount.dart';
import '../../../Data/areaData/Area.dart';
import '../../../Data/locationData/Location.dart';
import '../../../Data/models/area_search/search_page_area.dart';
import '../../../Data/otherData/Time.dart';
import '../../../Data/otherData/Tool.dart';
import '../../../Data/voucherData/Voucher.dart';
import '../../catch_order_manager/action/add_catch_order/location_pick_in_map.dart';
import '../../ingredient/text_field_content.dart';
import '../../ingredient/text_field_title.dart';
import '../ingredient/add_product_for_buy_request_order.dart';
import '../ingredient/buy_location_item.dart';
import '../ingredient/request_product_item.dart';

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

  requestBuyOrder order = requestBuyOrder(
      id: generateID(25),
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
      productList: [],
      costFee: Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0),
      buyLocation: [],
    subFee: 0,
  );

  //Hàm tổng hợp các mặt hàng
  String get_product_total() {
    double totalMoney = 0;
    for(int i = 0 ; i < order.productList.length; i++){
      totalMoney = totalMoney + (order.productList[i].number * order.productList[i].cost);
    }

    return 'Tổng cộng: ' + order.productList.length.toStringAsFixed(0) + ' mặt hàng, ' + getStringNumber(totalMoney) + 'Vnđ';
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
            Container(
              height: 10,
            ),

            text_field_title(title: 'Tên khách hàng *'),

            Container(
              height: 7,
            ),

            text_field_content(hintText: 'Nhập tên khách hàng', controller: CusNameControl),

            Container(
              height: 15,
            ),

            text_field_title(title: 'Số điện thoại khách hàng *'),

            Container(
              height: 7,
            ),

            text_field_content(hintText: 'Nhập số điện thoại khách hàng', controller: CusPhoneControl),

            Container(
              height: 15,
            ),

            text_field_title(title: 'Chọn điểm giao hàng *'),

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

            text_field_title(title: 'Điểm mua hàng *'),

            Container(
              height: 7,
            ),

            Container(
              child: ListView.builder(
                itemCount: order.buyLocation.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: buy_location_item(locationList: order.buyLocation, callback: () {setState(() {});}, index: index),
                  );
                },
              ),
            ),

            Container(
              height: 7,
            ),

            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thêm điểm mua',
                    style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Location location = Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: '');
                showDialog(
                  context: context,
                  builder: (context) {
                    return search_location_dialog(location: location, title: 'Thêm vị trí mua hàng',
                        event: () {
                          order.buyLocation.add(location);
                          setState(() {});
                        }
                    );
                  },
                );
              },
            ),

            Container(
              height: 15,
            ),

            text_field_title(title: 'Danh sách hàng hóa *'),

            Container(
              height: 7,
            ),

            Container(
              child: ListView.builder(
                itemCount: order.productList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: request_product_item(productList: order.productList, callback: () {setState(() {});}, index: index),
                  );
                },
              ),
            ),

            Container(
              height: 7,
            ),

            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Thêm hàng hóa',
                    style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 14,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return add_product_for_buy_request_order(order: order, event: () {setState(() {});});
                  },
                );
              },
            ),

            Container(
              height: 15,
            ),

            text_field_title(title: 'Chọn khu vực quản lý *'),

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
            if (start_request_order_controller.check_if_order_can_push(order)) {
              setState(() {
                loading = true;
              });
              double distance = await getDistance(order.buyLocation[0], order.locationGet);
              order.costFee = await getBikecostFee(area.id, 'requestBuyShipCost');
              order.owner.area = area.id;
              order.cost = getShipCost(distance, order.costFee);
              order.S1time = getCurrentTime();
              order.owner.name = CusNameControl.text.toString();
              order.owner.phone = CusPhoneControl.text.toString();
              await start_request_order_controller.push_buy_request_order_data(order);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Bạn cần hoàn thiện thông tin');
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
