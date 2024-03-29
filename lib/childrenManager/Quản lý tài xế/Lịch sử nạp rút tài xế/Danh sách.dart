import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';

import '../../../Mainmanager/Quản lý tài xế/Lịch sử nạp rút tài xế/Item danh sách.dart';
import '../../../dataClass/Lịch sử giao dịch.dart';

class Danhsachnapruttaixe extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachnapruttaixe({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachnapruttaixe> createState() => _DanhsachnapruttaixeState();
}

class _DanhsachnapruttaixeState extends State<Danhsachnapruttaixe> {
  TextEditingController searchController = TextEditingController();
  List<historyTransaction> transactionList = [];
  List<historyTransaction> chosenList = [];

  void sortChosenListByCreateTime(List<historyTransaction> chosenList) {
    chosenList.sort((a, b) {
      // Sắp xếp theo thời gian tạo giảm dần (mới nhất lên đầu)
      return b.transactionTime.year.compareTo(a.transactionTime.year) != 0
          ? b.transactionTime.year.compareTo(a.transactionTime.year)
          : (b.transactionTime.month.compareTo(a.transactionTime.month) != 0
          ? b.transactionTime.month.compareTo(a.transactionTime.month)
          : (b.transactionTime.day.compareTo(a.transactionTime.day) != 0
          ? b.transactionTime.day.compareTo(a.transactionTime.day)
          : (b.transactionTime.hour.compareTo(a.transactionTime.hour) != 0
          ? b.transactionTime.hour.compareTo(a.transactionTime.hour)
          : (b.transactionTime.minute.compareTo(a.transactionTime.minute) != 0
          ? b.transactionTime.minute.compareTo(a.transactionTime.minute)
          : b.transactionTime.second.compareTo(a.transactionTime.second)))));
    });
  }

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = transactionList
          .where((account) =>
      account.content.toLowerCase().contains(value.toLowerCase()) || account.money.toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void getData() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("historyTransaction").onValue.listen((event) {
      transactionList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        historyTransaction transaction = historyTransaction.fromJson(value);
        if (transaction.type == 2 || transaction.type == 1) {
          if (transaction.area == currentAccount.provinceCode) {
            transactionList.add(transaction);
            chosenList.add(transaction);
            print(chosenList.last.toJson().toString());
            sortChosenListByCreateTime(chosenList);
          }
        }
      });
      setState(() {

      });
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
            child: Container(
              width: 500,
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
                  hintText: 'Tìm kiếm giao dịch',
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
            top: 80,
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Mã giao dịch',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      child: Container(
                        width: (widget.width - 20)/5 - 1 - 20,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 18,
                                width: (widget.width - 20)/5 - 1 - 20,
                                child: AutoSizeText(
                                  'Thời gian giao dịch',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'muli',
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
                            )
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Số tiền giao dịch',
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
                    width: (widget.width - 20)/5 - 1,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Người thụ hưởng',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      child: Container(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontSize: 100
                          ),
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
                ],
              ),
            ),
          ),

          Positioned(
            top: 130,
            left: 10,
            child: Container(
              width: widget.width - 20,
              height: widget.height - 155,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)
              ),
              alignment: Alignment.center,
              child: (chosenList.length == 0) ? Text('không có giao dịch nào') : ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return Itemgiaodich(transaction: chosenList[index], width: widget.width, color: (index % 2 == 0) ? Colors.white : Color.fromARGB(255, 247, 250, 255),);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
