import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/text_line_in_item.dart';

class view_current_location_details extends StatefulWidget {
  final Location location;
  const view_current_location_details({super.key, required this.location});

  @override
  State<view_current_location_details> createState() => _view_current_location_detailsState();
}

class _view_current_location_detailsState extends State<view_current_location_details> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        height: 300,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              text_line_in_item(title: 'Đang ở gần: ', content: widget.location.mainText, color: Colors.black),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Copy vị trí chính xác', style: TextStyle(color: Colors.blueAccent),),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.location.latitude.toString() + ',' + widget.location.longitude.toString()));
            toastMessage('Đã copy vị trí');
          },
        )
      ],
    );
  }
}
