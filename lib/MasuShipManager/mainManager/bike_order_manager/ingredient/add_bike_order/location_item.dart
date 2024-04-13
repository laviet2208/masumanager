import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:masumanager/MasuShipManager/mainManager/catch_order_manager/action/add_catch_order/location_pick_in_map.dart';
import 'package:masumanager/MasuShipManager/mainManager/ingredient/search_location_dialog.dart';

class location_item extends StatelessWidget {
  final Location location;
  final int index;
  final int type; // 1: trả khách, 2: trả xe
  final VoidCallback callback;
  const location_item({super.key, required this.location, required this.index, required this.type, required this.callback});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 30,
      child: Row(
        children: [
          Container(
            width: width/3 - 50,
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: type == 1 ? ('Điểm trả khách ' + (index + 1).toString() + ': ') : ('Điểm trả xe ' + (index + 1).toString() + ': '),
                        style: TextStyle(
                          fontFamily: 'muli',
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )
                    ),

                    TextSpan(
                        text: location.longitude != 0 ? (location.mainText + ',' + location.secondaryText) : 'Chưa chọn vị trí',
                        style: TextStyle(
                          fontFamily: 'muli',
                          color: location.longitude != 0 ? Colors.black : Colors.red,
                          fontWeight: FontWeight.normal,
                        )
                    ),
                  ]
              ),
            ),
          ),

          GestureDetector(
            child: Container(
              width: 30,
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return search_location_dialog(location: location, event: () {
                    callback();
                  }, title: 'Chọn vị trí');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
