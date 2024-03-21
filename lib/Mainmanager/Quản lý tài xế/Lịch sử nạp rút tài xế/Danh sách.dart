import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20t%C3%A0i%20x%E1%BA%BF/L%E1%BB%8Bch%20s%E1%BB%AD%20n%E1%BA%A1p%20r%C3%BAt%20t%C3%A0i%20x%E1%BA%BF/Item%20danh%20s%C3%A1ch.dart';

import '../../../dataClass/Lịch sử giao dịch.dart';
import '../../Quản lý khu vực và tài khoản admin/Area.dart';

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
  List<Area> areaList1 = [];
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

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
          transactionList.add(transaction);
          chosenList.add(transaction);
          print(chosenList.last.toJson().toString());
          sortChosenListByCreateTime(chosenList);
        }
      });
      setState(() {

      });
    });
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList1.clear();
      areaList1.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList1.add(area);
      });
      setState(() {
        if (areaList1.length != 0) {
          chosenArea = areaList1.first;
        }
      });
    });
  }

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < transactionList.length ; i++) {
          chosenList.add(transactionList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < transactionList.length ; i++) {
          if (transactionList.elementAt(i).area == chosenArea.id) {
            chosenList.add(transactionList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
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
                  fontFamily: 'roboto',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm giao dịch',
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
            top: 20,
            right: 10,
            child: Container(
              width: 400,
              height: 40,
              child: DropdownButton<Area>(
                items: areaList1.map((e) => DropdownMenuItem<Area>(
                  value: e,
                  child: Text('Khu vực : ' + e.name),
                )).toList(),
                onChanged: (value) { dropdownCallback(value); },
                value: chosenArea,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
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
                    width: (widget.width - 20)/5 - 1,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Người thụ hưởng',
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
                    width: (widget.width - 20)/5 - 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      child: Container(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                            'Thao tác',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'roboto',
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
