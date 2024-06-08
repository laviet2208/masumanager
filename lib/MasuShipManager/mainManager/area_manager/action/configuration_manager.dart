import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/order_fee_manager/item_order_fee.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/order_fee_manager/order_fee_manager_page.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/restaurant_fee_manager/restaurant_fee_manager.dart';
import 'package:masumanager/MasuShipManager/mainManager/area_manager/action/weather_manager/weather_fee_manager.dart';
import '../../../Data/costData/Cost.dart';
import '../../../Data/areaData/Area.dart';

class configuration_manager extends StatefulWidget {
  final String id;
  const configuration_manager({Key? key, required this.id}) : super(key: key);

  @override
  State<configuration_manager> createState() => _configuration_managerState();
}

class _configuration_managerState extends State<configuration_manager> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int current_page = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Thiết lập số lượng tab
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  Widget get_body_widget() {
    if (current_page == 0) {
      return order_fee_manager_page(id: widget.id);
    }
    if (current_page == 1) {
      return restaurant_fee_manager(id: widget.id);
    }
    if (current_page == 2) {
      return weather_fee_manager(id: widget.id);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/4*3;
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height/5*4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text('Thông tin cấu hình', style: TextStyle(fontFamily: 'muli', color: Colors.black),),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.blue, // Màu của văn bản khi tab được chọn
            unselectedLabelColor: Colors.grey,
            onTap: (index) {
              setState(() {
                current_page = index;
              });
            },
            tabs: [
              Tab(text: 'Chiết khấu', icon: Icon(Icons.percent, size: 20,),),
              Tab(text: 'Nhà hàng', icon: Icon(Icons.restaurant, size: 20,),),
              Tab(text: 'Thời tiết', icon: Icon(Icons.sunny_snowing, size: 20,),),
            ],
          ),
        ),

        body: Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: get_body_widget()
              )
            ],
          ),
        ),
      ),
    );
  }
}
