import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/Product.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../../../Data/otherData/utils.dart';

class change_product_cost extends StatefulWidget {
  final Product product;
  const change_product_cost({super.key, required this.product});

  @override
  State<change_product_cost> createState() => _change_product_costState();
}

class _change_product_costState extends State<change_product_cost> {
  bool loading = false;
  final costController = TextEditingController();

  Future<void> change_food() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Product').child(widget.product.id).set(widget.product.toJson());
    setState(() {
      loading = false;
    });
    toastMessage('Sửa món thành công');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    costController.text = widget.product.cost.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width/2.5,
        height: MediaQuery.of(context).size.height/3,
        child: ListView(
          children: [
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Giá tiền sản phẩm (VNĐ)*',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: costController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Giá sản phẩm',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 20,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator(color: Colors.black,) : TextButton(
          onPressed: () async {
            if (costController.text.isNotEmpty) {
              setState(() {
                loading = false;
              });
              widget.product.describle = costController.text.toString();
              widget.product.status = 0;
              await change_food();
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Điền đủ thông tin');
            }

          },
          child: Text('Lưu', style: TextStyle(color: Colors.blueAccent),),
        ),

        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
        ),
      ],
    );
  }
}
