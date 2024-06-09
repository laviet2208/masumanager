import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/restaurant_manager/actions/partner_restaurant_actions/food_manager/item_food.dart';
import 'package:masumanager/MasuShipManager/mainManager/store_manager/actions/partner_store_actions/product_manager/actions/add_new_product.dart';
import 'package:masumanager/MasuShipManager/mainManager/store_manager/actions/partner_store_actions/product_manager/item_product.dart';
import '../../../../../Data/accountData/shopData/Product.dart';
import '../../../../../Data/accountData/shopData/shopAccount.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';

class product_manager extends StatefulWidget {
  final ShopAccount account;
  const product_manager({super.key, required this.account});

  @override
  State<product_manager> createState() => _product_managerState();
}

class _product_managerState extends State<product_manager> {
  List<Product> productList = [];
  List<Product> chosenList = [];

  void get_product_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Product").orderByChild('owner').equalTo(widget.account.id).onValue.listen((event) {
      productList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Product shopAccount= Product.fromJson(value);
        productList.add(shopAccount);
        chosenList.add(shopAccount);
        sortChosenListByCreateTime(chosenList);
      });
      setState(() {

      });
    });
  }

  void sortChosenListByCreateTime(List<Product> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.createTime.year.compareTo(a.createTime.year) != 0
          ? b.createTime.year.compareTo(a.createTime.year)
          : (b.createTime.month.compareTo(a.createTime.month) != 0
          ? b.createTime.month.compareTo(a.createTime.month)
          : (b.createTime.day.compareTo(a.createTime.day) != 0
          ? b.createTime.day.compareTo(a.createTime.day)
          : (b.createTime.hour.compareTo(a.createTime.hour) != 0
          ? b.createTime.hour.compareTo(a.createTime.hour)
          : (b.createTime.minute.compareTo(a.createTime.minute) != 0
          ? b.createTime.minute.compareTo(a.createTime.minute)
          : b.createTime.second.compareTo(a.createTime.second)))));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_product_data();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 120;
    double height = MediaQuery.of(context).size.height/5*4;
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      title: Text('Quản lý danh sách sản phẩm',style: TextStyle(fontFamily: 'muli', fontSize: 14, fontWeight: FontWeight.bold),),

      content: Container(
        width: MediaQuery.of(context).size.width - 100,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: 10,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 30,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          border: Border.all(
                              width: 1
                          )
                      ),
                      child: Center(
                        child: Text(
                          'Thêm sản phẩm',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return add_new_product(account: widget.account);
                        },
                      );
                    },
                  ),

                  Container(width: 5,),

                  GestureDetector(
                    child: Icon(Icons.history, color: Colors.black,),
                    onTap: () {setState(() {});},
                  )
                ],
              ),
            ),

            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Container(
                width: width,
                height: 45,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 250, 255),
                    border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 225, 225, 226)
                    )
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 49,
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (width - 50)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                          child: AutoSizeText(
                            'Thông tin sản phẩm',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (width - 50)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                          child: AutoSizeText(
                            'Trạng thái sản phẩm',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (width - 50)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                          child: AutoSizeText(
                            'Giá tiền sản phẩm',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (width - 50)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                          child: AutoSizeText(
                            'Hình ảnh',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),

                    Container(
                      width: 1,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 225, 225, 226)
                      ),
                    ),

                    Container(
                      width: (width - 50)/5 - 1,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 13, bottom: 13),
                          child: AutoSizeText(
                            'Thao tác',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'muli',
                                color: Colors.black,
                                fontSize: 100
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 95,
              left: 10,
              right: 10,
              bottom: 10,
              child: Container(
                child: ListView.builder(
                  itemCount: chosenList.length,
                  itemBuilder: (context, index) {
                    return item_product(product: chosenList[index], index: index);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
