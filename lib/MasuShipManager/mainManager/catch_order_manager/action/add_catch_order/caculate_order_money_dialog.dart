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
  Cost bikeCost = Cost(departKM: 0, departCost: 0, milestoneKM1: 0, milestoneKM2: 0, perKMcost1: 0, perKMcost2: 0, perKMcost3: 0, discountLimit: 0, discountMoney: 0, discountPercent: 0);
  bool loading = false;

  getBikecost() async {
    final reference = FirebaseDatabase.instance.reference();
    DatabaseEvent snapshot = await reference.child('CostFee/' + widget.order.shipper.area + '/bikeShipCost').once();
    final dynamic catchOrderData = snapshot.snapshot.value;
    if (catchOrderData != null) {
      bikeCost = Cost.fromJson(catchOrderData);
    }
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
        width: (MediaQuery.of(context).size.width/5),
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
                      text:  widget.order.locationGet.longitude != 0 ? (getStringNumber(getShipCost(widget.distance, bikeCost)) + 'đ') : 'Hiển thị khi tới nơi',
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
                      text: widget.order.locationGet.longitude != 0 ? (widget.distance.toStringAsFixed(1).toString() + 'km') : 'Hiển thị khi tới nơi',
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
            setState(() {
              loading = true;
            });
            widget.order.cost = getShipCost(widget.distance, bikeCost);
            widget.order.costFee = bikeCost;
            await pushCatchOrder(widget.order);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
