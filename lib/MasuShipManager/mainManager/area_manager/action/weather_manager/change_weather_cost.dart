import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/costData/weatherCost.dart';

class change_weather_cost extends StatefulWidget {
  final String id;
  final weatherCost cost;
  const change_weather_cost({super.key, required this.id, required this.cost});

  @override
  State<change_weather_cost> createState() => _change_weather_costState();
}

class _change_weather_costState extends State<change_weather_cost> {
  bool loading = false;
  final weatherName = TextEditingController();
  final Cost = TextEditingController();

  Future<void> push_weather_cost() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('CostFee').child(widget.id).child('weatherCost').set(widget.cost);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherName.text = widget.cost.weatherTitle.toString();
    Cost.text = widget.cost.cost.toStringAsFixed(0);
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
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Trạng thái thời tiết',
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
                        controller: weatherName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên trạng thái thời tiết',
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

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Phụ phí thời tiết',
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
                          hintText: 'Nhập phụ phí thời tiết',
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
            if (weatherName.text.isNotEmpty && Cost.text.isNotEmpty) {
              widget.cost.cost = double.parse(Cost.text.toString());
              widget.cost.weatherTitle = weatherName.text.toString();
              setState(() {
                loading = true;
              });
              await push_weather_cost();
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            }
          },
          child: !loading ? Text(
            'Đồng ý',
            style: TextStyle(
                fontFamily: 'roboto',
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
