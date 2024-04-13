import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catch_order_type_3_data/motherOrder.dart';
import 'package:masumanager/MasuShipManager/Data/costData/Cost.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/bike_order_manager/ingredient/add_bike_order/add_bike_order_controller.dart';
import '../../../../Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/otherData/utils.dart';

class add_bike_order_dialog_step_3 extends StatefulWidget {
  final motherOrder order;
  final Cost costFee;
  final List<Location> peopleLocation;
  final List<Location> bikeLocation;
  const add_bike_order_dialog_step_3({super.key, required this.order, required this.peopleLocation, required this.bikeLocation, required this.costFee});

  @override
  State<add_bike_order_dialog_step_3> createState() => _add_bike_order_dialog_step_3State();
}

class _add_bike_order_dialog_step_3State extends State<add_bike_order_dialog_step_3> {
  bool loading = false;

  RichText getRichText(String title, String content, Color color) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: title,
                style: TextStyle(
                  fontFamily: 'muli',
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )
            ),

            TextSpan(
                text: content,
                style: TextStyle(
                  fontFamily: 'muli',
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                )
            ),
          ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3;
    return AlertDialog(
      title: Text('Tính toán của đơn', style: TextStyle(fontFamily: 'muli'),),
      content: Container(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Danh sách điểm trả người',
                  style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            
            Container(height: 10,),
            
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: ListView.builder(
                  itemCount: widget.peopleLocation.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Điểm trả khách ' + (index + 1).toString() + ': ',
                                          style: TextStyle(
                                            fontFamily: 'muli',
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          )
                                      ),

                                      TextSpan(
                                          text: widget.peopleLocation[index].longitude != 0 ? (widget.peopleLocation[index].mainText + ',' + widget.peopleLocation[index].secondaryText) : 'Chưa chọn vị trí',
                                          style: TextStyle(
                                            fontFamily: 'muli',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),

                            Container(height: 5,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: FutureBuilder(
                                future: getDistance(widget.order.locationSet, widget.peopleLocation[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return getRichText('Khoảng cách: ', '...', Colors.black);
                                  }

                                  if (snapshot.hasError) {
                                    return getRichText('Khoảng cách: ', 'Lỗi khoảng cách', Colors.black);
                                  }

                                  if (!snapshot.hasData) {
                                    return getRichText('Khoảng cách: ', 'Lỗi khoảng cách', Colors.black);
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: getRichText('Khoảng cách: ', snapshot.data!.toStringAsFixed(1) + ' Km', Colors.blueAccent),
                                      ),

                                      Container(height: 5,),

                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: getRichText('Thành tiền: ', getStringNumber(getCost(snapshot.data!, widget.costFee)) + '.đ', Colors.redAccent),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),

                            Container(height: 10,),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Danh sách điểm trả xe',
                  style: TextStyle(
                      fontFamily: 'muli',
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            Container(height: 10,),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: ListView.builder(
                  itemCount: widget.bikeLocation.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Điểm trả xe ' + (index + 1).toString() + ': ',
                                          style: TextStyle(
                                            fontFamily: 'muli',
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          )
                                      ),

                                      TextSpan(
                                          text: widget.bikeLocation[index].longitude != 0 ? (widget.bikeLocation[index].mainText + ',' + widget.bikeLocation[index].secondaryText) : 'Chưa chọn vị trí',
                                          style: TextStyle(
                                            fontFamily: 'muli',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          )
                                      ),
                                    ]
                                ),
                              ),
                            ),

                            Container(height: 5,),

                            Container(
                              alignment: Alignment.centerLeft,
                              child: FutureBuilder(
                                future: getDistance(widget.order.locationSet, widget.peopleLocation[index]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return getRichText('Khoảng cách: ', '...', Colors.black);
                                  }

                                  if (snapshot.hasError) {
                                    return getRichText('Khoảng cách: ', 'Lỗi khoảng cách', Colors.black);
                                  }

                                  if (!snapshot.hasData) {
                                    return getRichText('Khoảng cách: ', 'Lỗi khoảng cách', Colors.black);
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: getRichText('Khoảng cách: ', snapshot.data!.toStringAsFixed(1) + ' Km', Colors.blueAccent),
                                      ),

                                      Container(height: 5,),

                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: getRichText('Thành tiền: ', getStringNumber(getCost(snapshot.data!, widget.costFee)) + '.đ', Colors.redAccent),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),

                            Container(height: 10,),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Container(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            widget.order.id = generateID(25);
            widget.order.createTime = getCurrentTime();
            setState(() {
              loading = true;
            });
            List<catchOrderType3> custom_order_list = [];
            List<catchOrderType3> bike_order_list = [];
            //thêm đơn chở người
            for (int i = 0; i < widget.peopleLocation.length; i++) {
              double money = await getCostFuture(widget.order.locationSet, widget.peopleLocation[i], widget.costFee);
              catchOrderType3 orderType3 = catchOrderType3(
                  id: generateID(25),
                  locationSet: widget.order.locationSet,
                  locationGet: widget.peopleLocation[i],
                  cost: money,
                  owner: widget.order.owner,
                  shipper: widget.order.shipper,
                  status: 'A',
                  voucher: widget.order.voucher,
                  S1time: getCurrentTime(),
                  S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  costFee: widget.costFee,
                  subFee: 0,
                  type: 1,
                  motherOrder: widget.order.id
              );
              orderType3.cost = orderType3.cost;
              custom_order_list.add(orderType3);
              widget.order.orderList.add(orderType3.id);
            }

            //thêm đơn lái xe hộ
            for (int i = 0; i < widget.bikeLocation.length; i++) {
              double money = await getCostFuture(widget.order.locationSet, widget.peopleLocation[i], widget.costFee);
              catchOrderType3 orderType3 = catchOrderType3(
                  id: generateID(25),
                  locationSet: widget.order.locationSet,
                  locationGet: widget.bikeLocation[i],
                  cost: money,
                  owner: widget.order.owner,
                  shipper: widget.order.shipper,
                  status: 'A',
                  voucher: widget.order.voucher,
                  S1time: getCurrentTime(),
                  S2time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S3time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  S4time: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),
                  costFee: widget.costFee,
                  subFee: 0,
                  type: 2,
                  motherOrder: widget.order.id
              );
              orderType3.cost = orderType3.cost;
              bike_order_list.add(orderType3);
              widget.order.orderList.add(orderType3.id);
            }

            add_bike_order_controller.push_mother_order_data(widget.order);
            for (int i = 0; i < custom_order_list.length; i++) {
              await add_bike_order_controller.push_child_order_data(custom_order_list[i]);
            }
            for (int i = 0; i < bike_order_list.length; i++) {
              await add_bike_order_controller.push_child_order_data(bike_order_list[i]);
            }
            toastMessage('Đẩy đơn thành công');
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text('Xác nhận và lên đơn', style: TextStyle(color: Colors.blueAccent),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
        ),
      ],
    );
  }
}
