import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import '../../../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';
import '../../../../Data/otherData/Tool.dart';

class caculate_free_request_order_money_dialog extends StatefulWidget {
  final requestBuyOrder order;
  final double distance;
  const caculate_free_request_order_money_dialog({Key? key, required this.order, required this.distance,}) : super(key: key);

  @override
  State<caculate_free_request_order_money_dialog> createState() => _caculate_free_request_order_money_dialogState();
}

class _caculate_free_request_order_money_dialogState extends State<caculate_free_request_order_money_dialog> {
  bool loading = false;

  //Lấy phí ship
  int getCost(double distance) {
    int cost = 0;
    if (distance >= widget.order.costFee.departKM) {
      cost += widget.order.costFee.departKM.toInt() * widget.order.costFee.departCost.toInt(); // Giá cước cho km đề pa đầu tiên (10.000 VND/km * 2km)
      distance -= widget.order.costFee.departKM; // Trừ đi số km đề pa đã tính giá cước
      cost = cost + ((distance - widget.order.costFee.departKM) * widget.order.costFee.perKMcost).toInt();
    } else {
      cost += (distance * widget.order.costFee.departCost).toInt(); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }

  //Lấy phí đơn hàng
  double get_order_cost() {
    double cost = 0;
    for (int i = 0; i < widget.order.productList.length; i ++) {
      cost = cost + (widget.order.productList[i].cost * widget.order.productList[i].number);
    }
    return cost;
  }

  //Đẩy đơn hàng
  Future<void> push_request_order(requestBuyOrder order) async {
    try {
      setState(() {
        loading = true;
      });
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order').child(order.id).set(order.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tổng giá trị đơn'),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Phí ship: ',
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(getCost(widget.distance).toDouble()) + 'đ',
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Phí đơn hàng: ',
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(get_order_cost()),
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Tổng cộng: ',
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: getStringNumber(get_order_cost() + getCost(widget.distance)),
                      style: TextStyle(
                        fontFamily: 'arial',
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator(color: Colors.black,) : TextButton(
          child: Text(
            'Xác nhận',
            style: TextStyle(
              fontFamily: 'arial',
              color: Colors.blueAccent,
            ),
          ),
          onPressed: () async {
            widget.order.cost = getCost(widget.distance).toDouble();
            await push_request_order(widget.order);
            toastMessage('Đẩy đơn thành công');
            Navigator.of(context).pop();
            setState(() {
              loading = false;
            });
          },
        ),

        TextButton(
          child: Text(
            'Hủy',
            style: TextStyle(
              fontFamily: 'arial',
              color: Colors.redAccent,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
