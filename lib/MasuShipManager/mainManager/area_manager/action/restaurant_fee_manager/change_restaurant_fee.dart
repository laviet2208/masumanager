import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/costData/restaurantCost.dart';

class change_restaurant_fee extends StatefulWidget {
  final String id;
  final restaurantCost cost;
  const change_restaurant_fee({super.key, required this.id, required this.cost});

  @override
  State<change_restaurant_fee> createState() => _change_restaurant_feeState();
}

class _change_restaurant_feeState extends State<change_restaurant_fee> {
  bool loading = false;
  final Cost = TextEditingController();

  Future<void> push_weather_cost() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('CostFee').child(widget.id).child('restaurantCost').set(widget.cost);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Cost.text = widget.cost.discount.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thay đổi cấu hình thời tiết'),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        height: 400,
        child: ListView(
          children: [
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Phần trăm chiết khấu nhà hàng',
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
                        controller: Cost,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập chiết khấu nhà hàng',
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
              height: 10,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (Cost.text.isNotEmpty) {
              if (double.parse(Cost.text.toString()) < 100 && double.parse(Cost.text.toString()) >= 1) {
                widget.cost.discount = double.parse(Cost.text.toString());
                setState(() {
                  loading = true;
                });
                await push_weather_cost();
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              }
            }
          },
          child: !loading ? Text(
            'Đồng ý',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.blueAccent
            ),
          ) : CircularProgressIndicator(color: Colors.blueAccent,),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
                color: Colors.redAccent
            ),
          ),
        ),
      ],
    );
  }
}