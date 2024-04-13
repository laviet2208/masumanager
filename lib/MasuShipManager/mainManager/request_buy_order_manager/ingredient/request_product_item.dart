import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/requestBuyOrderData/requestProduct.dart';

class request_product_item extends StatelessWidget {
  final List<requestProduct> productList;
  final int index;
  final VoidCallback callback;
  const request_product_item({super.key, required this.productList, required this.index, required this.callback});

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
                          text: 'Món ' + (index + 1).toString() + ': ',
                          style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                      ),

                      TextSpan(
                          text: productList[index].name + ' - Số lượng: ' + productList[index].number.toString() + ' ' + productList[index].unit,
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
                productList.removeAt(index);
                callback();
              },
            ),
          ],
        ),
      ),
    );
  }
}
