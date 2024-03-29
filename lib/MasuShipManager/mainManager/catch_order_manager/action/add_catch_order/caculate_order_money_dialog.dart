import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/catchOrder.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../Data/costData/Cost.dart';
import '../../../../Data/otherData/Tool.dart';

class caculate_order_money_dialog extends StatefulWidget {
  final CatchOrder order;
  final double distance;
  const caculate_order_money_dialog({Key? key, required this.order, required this.distance}) : super(key: key);

  @override
  State<caculate_order_money_dialog> createState() => _caculate_order_money_dialogState();
}

class _caculate_order_money_dialogState extends State<caculate_order_money_dialog> {
  Cost bikeCost = Cost(departKM: 2, departCost: 25000, perKMcost: 15000, discount: 20);
  bool loading = false;

  getBikecost() async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('CostFee/' + widget.order.shipper.area + '/Bike').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      Cost cost = Cost.fromJson(catchOrderData);
      bikeCost.discount = cost.discount;
      bikeCost.perKMcost = cost.perKMcost;
      bikeCost.departCost = cost.departCost;
      bikeCost.departKM = cost.departKM;
    }
  }

  int getCost(double distance) {
    int cost = 0;
    if (distance >= bikeCost.departKM) {
      cost += bikeCost.departKM.toInt() * bikeCost.departCost.toInt(); // Giá cước cho km đề pa đầu tiên (10.000 VND/km * 2km)
      distance -= bikeCost.departKM; // Trừ đi số km đề pa đã tính giá cước
      cost = cost + ((distance - bikeCost.departKM) * bikeCost.perKMcost).toInt();
    } else {
      cost += (distance * bikeCost.departCost).toInt(); // Giá cước cho khoảng cách dưới 2km
    }
    return cost;
  }

  Future<void> pushCatchOrder(CatchOrder catchorder) async {
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Order').child(catchorder.id).set(catchorder.toJson());
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBikecost();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tính toán của đơn', style: TextStyle(fontFamily: 'muli'),),
      content: Container(
        width: (MediaQuery.of(context).size.width/7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Tổng số tiền đơn: ',
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
                      text: 'Tổng số km: ',
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.distance.toStringAsFixed(1).toString() + 'km',
                      style: TextStyle(
                        fontFamily: 'arial',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
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
            widget.order.costFee = bikeCost;
            await pushCatchOrder(widget.order);
          },
        )
      ],
    );
  }
}
