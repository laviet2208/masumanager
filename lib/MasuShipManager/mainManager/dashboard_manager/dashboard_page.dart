import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/dashboard_manager/day_order_dashboard.dart';
import 'package:masumanager/MasuShipManager/mainManager/dashboard_manager/month_order_dashboard.dart';
import 'package:masumanager/MasuShipManager/mainManager/dashboard_manager/week_order_dashboard.dart';

class dashboard_page extends StatefulWidget {
  const dashboard_page({super.key});

  @override
  State<dashboard_page> createState() => _dashboard_pageState();
}

class _dashboard_pageState extends State<dashboard_page> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = MediaQuery.of(context).size.height - 60;

    return Container(
      width: width,
      height: height,
      child: ListView(
        children: [
          Container(
            height: 300,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: day_order_dashboard(),
                ),

                Positioned(
                  top: 0,
                  bottom: 0,
                  right: (width - (MediaQuery.of(context).size.width/3 - 40))/2,
                  child: week_order_dashboard(),
                ),

                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: month_order_dashboard(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
