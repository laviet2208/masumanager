import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/Product.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../../../Data/otherData/utils.dart';

class on_off_product extends StatefulWidget {
  final Product product;
  const on_off_product({super.key, required this.product});

  @override
  State<on_off_product> createState() => _on_off_productState();
}

class _on_off_productState extends State<on_off_product> {

  Future<void> push_new_food(Product product) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Product').child(product.id).set(product.toJson());
    toastMessage('Tắt bật món thành công');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xác nhận bật/tắt sản phẩm', style: TextStyle(fontSize: 11),),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (widget.product.status == 0) {
              widget.product.status = 1;
              await push_new_food(widget.product);
              setState(() {

              });
              Navigator.of(context).pop();
            } else {
              widget.product.status = 0;
              await push_new_food(widget.product);
              setState(() {

              });
              Navigator.of(context).pop();
            }
          },
          child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
        ),
      ],
    );
  }
}
