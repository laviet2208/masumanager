import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/history_transaction/history_transaction_item.dart';
import '../../../Data/areaData/Area.dart';
import '../../../Data/historyData/historyTransactionData.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';

class history_transaction_manager extends StatefulWidget {
  const history_transaction_manager({super.key});

  @override
  State<history_transaction_manager> createState() => _history_transaction_managerState();
}

class _history_transaction_managerState extends State<history_transaction_manager> {
  List<historyTransactionData> transactionList = [];
  List<historyTransactionData> chosenList = [];
  List<String> type_list = ['Tất cả','Nạp tiền', 'Rút tiền',];
  String chosenType = '';
  List<Area> areaList = [];
  TextEditingController searchController = TextEditingController();
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void get_transaction_list() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("historyTransaction").onValue.listen((event) {
      transactionList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        if (int.parse(value['type'].toString()) == 1 || int.parse(value['type'].toString()) == 2) {
          historyTransactionData account = historyTransactionData.fromJson(value);
          transactionList.add(account);
          chosenList.add(account);
        }
      });
      setState(() {

      });
    });
  }

  void get_area_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      areaList.add(Area(id: 'all', name: 'Tất cả', money: 0, status: 0));
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {
        if (areaList.length != 0) {
          chosenArea = areaList.first;
        }
      });
    });
  }

  void sortChosenListByCreateTime(List<historyTransactionData> chosenList) {
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
      account.content.toLowerCase().contains(value.toLowerCase()) || account.id.toLowerCase().contains(value.toLowerCase()) || account.money.toString().toLowerCase().contains(value.toLowerCase()))
          .toList();
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

  void drop_down_type(String? selectedValue) {
    if (selectedValue is String) {
      chosenType = selectedValue;
      if (chosenType == 'Tất cả') {
        chosenList.clear();
        for(int i = 0 ; i < transactionList.length ; i++) {
          chosenList.add(transactionList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      }

      if (chosenType == 'Nạp tiền') {
        chosenList.clear();
        for(int i = 0 ; i < transactionList.length ; i++) {
          if (transactionList.elementAt(i).type == 1) {
            chosenList.add(transactionList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }

      if (chosenType == 'Rút tiền') {
        chosenList.clear();
        for(int i = 0 ; i < transactionList.length ; i++) {
          if (transactionList.elementAt(i).type == 2) {
            chosenList.add(transactionList.elementAt(i));
            setState(() {

            });
          }
        }
        setState(() {

        });
      }
    }

    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenType = type_list.first;
    get_area_data();
    get_transaction_list();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = MediaQuery.of(context).size.height - 60;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          //tìm kiếm giao dịch
          Positioned(
            top: 20,
            left: 0,
            child: Container(
              width: 250,
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

          //dropdown thể loại
          Positioned(
            top: 20,
            right: 260,
            child: Container(
              width: 200,
              height: 40,
              child: DropdownButton<String>(
                items: type_list.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { drop_down_type(value); },
                value: chosenType,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),
          ),

          //dropdown khu vực
          Positioned(
            top: 20,
            right: 0,
            child: Container(
              width: 250,
              height: 40,
              child: DropdownButton<Area>(
                items: areaList.map((e) => DropdownMenuItem<Area>(
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
            left: 0,
            right: 0,
            child: Container(
              width: width,
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
                    width: (width)/5 - 1,
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
                    width: (width)/5 - 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                      child: Container(
                        width: (width)/5 - 1 - 20,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                height: 18,
                                width: (width)/5 - 1 - 20,
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
                    width: (width)/5 - 1,
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
                    width: (width)/5 - 1,
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
                    width: (width)/5 - 1,
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
            top: 131,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              child: ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index) {
                  return history_transaction_item(transaction: chosenList[index], index: index);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
