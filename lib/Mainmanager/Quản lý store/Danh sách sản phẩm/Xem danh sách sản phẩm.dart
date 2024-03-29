import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/accountShop.dart';

import '../../../dataClass/Product.dart';
import '../Thêm sản phẩm.dart';
import 'Itemproduct.dart';

class Xemdanhsachsanpham extends StatefulWidget {
  final double width;
  final double height;
  final accountShop shop;
  const Xemdanhsachsanpham({Key? key, required this.width, required this.height, required this.shop}) : super(key: key);

  @override
  State<Xemdanhsachsanpham> createState() => _XemdanhsachmonanState();
}

class _XemdanhsachmonanState extends State<Xemdanhsachsanpham> {
  List<Product> productList = [];
  List<Product> chosenList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Product").onValue.listen((event) {
      productList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Product food= Product.fromJson(value);
        if(food.owner.id == widget.shop.id) {
          productList.add(food);
          chosenList.add(food);
        }
      });
      setState(() {

      });
    });
  }

  TextEditingController searchController = TextEditingController();

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = productList
          .where((account) =>
      account.name.toLowerCase().contains(value.toLowerCase()) ||
          account.content.toLowerCase().contains(value.toLowerCase()) ||
          account.cost.toString().toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  '+ Thêm mới',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'arial',
                      fontSize: 14
                  ),
                ),
              ),
              onTap: () {
                ThemSanPham.showDialogthemmonan(widget.width/2, 500, context,widget.shop,TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController());
              },
            ),
          ),

          Positioned(
            top: 20,
            left: 140,
            child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              ),
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'muli',
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: 50,
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
                    width: (widget.width - 20)/10,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
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
                    width: (widget.width - 20)/5,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Tên sản phẩm',
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
                    width: (widget.width - 20)/8,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Giá tiền(VNĐ)',
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
                    width: widget.width - ((widget.width - 20)/8) - ((widget.width - 20)/5) - ((widget.width - 20)/10) - 3,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          textAlign: TextAlign.center,
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
            top: 150,
            left: 10,
            child: Container(
              width: widget.width-20,
              height: widget.height - 160,
              alignment: Alignment.center,
              child: (chosenList.length == 0) ? Text('không có sản phẩm nào') : ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return ItemProduct(width: widget.width - 20, product: chosenList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
