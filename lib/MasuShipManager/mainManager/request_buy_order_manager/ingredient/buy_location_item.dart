import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';

class buy_location_item extends StatelessWidget {
  final List<Location> locationList;
  final int index;
  final VoidCallback callback;
  const buy_location_item({super.key, required this.locationList, required this.callback, required this.index});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/3;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: width - 20,
        height: 30,
        child: Row(
          children: [
            Container(
              width: width - 50,
              alignment: Alignment.centerLeft,
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Điểm ' + (index + 1).toString() + ': ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),

                      TextSpan(
                          text: locationList[index].mainText + ', ' + locationList[index].secondaryText,
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
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
                  Icons.delete_forever_sharp,
                  color: Colors.redAccent,
                ),
              ),
              onTap: () {
                locationList.removeAt(index);
                callback();
              },
            ),
          ],
        ),
      ),
    );
  }
}
