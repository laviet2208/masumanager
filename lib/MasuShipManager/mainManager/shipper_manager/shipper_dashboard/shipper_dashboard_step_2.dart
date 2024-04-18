import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/heading_title.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_dashboard/shipper_dashboard_item.dart';

import '../../../Data/otherData/Time.dart';
import 'heading_title_for_shipper_dash.dart';

class shipper_dashboard_step_2 extends StatefulWidget {
  final List<Time> timeList;
  final shipperAccount account;
  const shipper_dashboard_step_2({super.key, required this.timeList, required this.account});

  @override
  State<shipper_dashboard_step_2> createState() => _shipper_dashboard_step_2State();
}

class _shipper_dashboard_step_2State extends State<shipper_dashboard_step_2> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: MediaQuery.of(context).size.width/5*4,
        height: MediaQuery.of(context).size.height/5*4,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: heading_title_for_shipper_dash(numberColumn: 6, listTitle: ['','Chở người','Mua hộ','Đồ ăn','Express','Tổng thời gian'], width: MediaQuery.of(context).size.width/5*4 - 20, height: 50),
                ),

                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  bottom: 80,
                  child: Container(
                    child: ListView.builder(
                      itemCount: widget.timeList.length,
                      itemBuilder: (context, index) {
                        return shipper_dashboard_item(account: widget.account, time: widget.timeList[index], index: index);
                      },
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 70,
                    child: ListView(
                      children: [
                        Container(
                          height: 15,
                          child: Row(
                            children: [
                              Container(width: 15, decoration: BoxDecoration(color: Colors.green),),

                              Container(
                                width: 10,
                              ),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Đi làm bình thường',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(height: 4,),

                        Container(
                          height: 15,
                          child: Row(
                            children: [
                              Container(width: 15, decoration: BoxDecoration(color: Colors.redAccent),),

                              Container(
                                width: 10,
                              ),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nghỉ không phép',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    fontSize: 12,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(height: 4,),

                        Container(
                          height: 15,
                          child: Row(
                            children: [
                              Container(width: 15, decoration: BoxDecoration(color: Colors.blueAccent),),

                              Container(
                                width: 10,
                              ),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nghỉ có phép',
                                  style: TextStyle(
                                    fontFamily: 'muli',
                                    fontSize: 12,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
