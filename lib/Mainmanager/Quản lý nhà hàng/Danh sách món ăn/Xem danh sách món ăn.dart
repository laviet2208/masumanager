import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/accountShop.dart';

import '../../../dataClass/Product.dart';
import '../Thêm món ăn.dart';
import 'Itemfood.dart';

class Xemdanhsachmonan extends StatefulWidget {
  final double width;
  final double height;
  final String data;
  final accountShop shop;
  const Xemdanhsachmonan({Key? key, required this.width, required this.height, required this.shop, required this.data}) : super(key: key);

  @override
  State<Xemdanhsachmonan> createState() => _XemdanhsachmonanState();
}

class _XemdanhsachmonanState extends State<Xemdanhsachmonan> {
  List<Product> productList = [];
  List<Product> chosenList = [];

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child(widget.data == 'Restaurant' ? 'Food' : 'Product').onValue.listen((event) {
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
        sortChosenListByCreateTime(chosenList);
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

  void sortChosenListByCost(List<Product> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo rẻ tới đắt
      return a.cost.compareTo(b.cost);
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
                ThemMonAn.showDialogthemmonan(widget.width/2, 500, context,widget.shop,TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(),widget.data == 'Restaurant' ? 'Food' : 'Product');
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
                  fontFamily: 'roboto',
                ),
                decoration: InputDecoration(
                  hintText: widget.data == 'Restaurant' ? 'Tìm kiếm món ăn' : 'Tìm kiếm sản phẩm',
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'roboto',
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
                              fontFamily: 'roboto',
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
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: (widget.width - 20)/5 - 20,
                                height: 20,
                                child: AutoSizeText(
                                    widget.data == 'Restaurant' ? 'Tên món ăn' : 'Tên sản phẩm',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'roboto',
                                        color: Colors.black,
                                        fontSize: 100
                                    ),
                                  ),
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onTap: () {
                                  sortChosenListByCreateTime(chosenList);
                                  setState(() {

                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 20,
                                width: (widget.width - 20)/8 - 20,
                                child: AutoSizeText(
                                    'Giá tiền(VNĐ)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'roboto',
                                        color: Colors.black,
                                        fontSize: 100
                                    ),
                                  ),
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                child: Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onTap: () {
                                  sortChosenListByCost(chosenList);
                                  setState(() {

                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              fontFamily: 'roboto',
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
              child: (chosenList.length == 0) ? (widget.data == 'Restaurant' ? Text('không có món ăn nào') : Text('Không có sản phẩm')) : ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return ItemFood(width: widget.width - 20, product: chosenList[index], color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255), data: widget.data == 'Restaurant' ? 'Food' : 'Product',);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
