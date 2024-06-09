import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/mainManager/store_manager/actions/store_directory_actions/add_store_directory.dart';
import '../../../Data/accountData/shopData/shopDirectory.dart';
import '../../../Data/areaData/Area.dart';
import 'item_store_directory.dart';

class store_directory_manager extends StatefulWidget {
  const store_directory_manager({super.key});

  @override
  State<store_directory_manager> createState() => _store_directory_managerState();
}

class _store_directory_managerState extends State<store_directory_manager> {
  List<shopDirectory> directoryList = [];
  List<shopDirectory> chosenList = [];
  List<Area> areaList = [];
  TextEditingController searchController = TextEditingController();
  Area chosenArea = Area(id: '', name: '', money: 0, status: 0);

  void get_area_list() {
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

  void dropdownCallback(Area? selectedValue) {
    if (selectedValue is Area) {
      chosenArea = selectedValue;
      if (chosenArea.id == 'all') {
        chosenList.clear();
        for(int i = 0 ; i < directoryList.length ; i++) {
          chosenList.add(directoryList.elementAt(i));
          setState(() {

          });
        }
        setState(() {

        });
      } else {
        chosenList.clear();
        for(int i = 0 ; i < directoryList.length ; i++) {
          if (directoryList.elementAt(i).area == chosenArea.id) {
            chosenList.add(directoryList.elementAt(i));
            setState(() {

            });
          }
        }
      }

    }

    setState(() {

    });
  }

  void onSearchTextChanged(String value) {
    setState(() {
      chosenList = directoryList
          .where((account) =>
      account.mainName.toLowerCase().contains(value.toLowerCase()) ||
          account.subName.toLowerCase().contains(value.toLowerCase()) ||
          account.id.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  void sortChosenListAZ(List<shopDirectory> chosenList) {
    chosenList.sort((a, b) => a.mainName.compareTo(b.mainName));
  }

  void get_directory() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("StoreDirectory").onValue.listen((event) {
      directoryList.clear();
      chosenList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        shopDirectory directory = shopDirectory.fromJson(value);
        directoryList.add(directory);
        chosenList.add(directory);
        sortChosenListAZ(chosenList);
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_list();
    get_directory();
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
          //Tìm kiếm danh mục Shop
          Positioned(
            top: 10,
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
                  fontFamily: 'muli',
                ),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm danh mục Shop',
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

          //Lọc theo khu vực
          Positioned(
            top: 10,
            right: 0,
            child: Container(
              width: 200,
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

          //Thêm danh mục
          Positioned(
            top: 10,
            left: 250,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                ),
                child: Center(
                  child: Text(
                    'Thêm danh mục',
                    style: TextStyle(
                        fontFamily: 'muli',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return add_store_directory();
                  },
                );
              },
            ),
          ),

          //Thanh head
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thông tin danh mục',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thuộc khu vực',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Số lượng Shop',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Trạng thái',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                        child: AutoSizeText(
                          'Thao tác',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: 'arial',
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
                ],
              ),
            ),
          ),


          Positioned(
            top: 130,
            bottom: 0,
            left: 0,
            right: 0,
            child: directoryList != 0 ? Container(
              child: ListView.builder(
                itemCount: chosenList.length,
                itemBuilder: (context, index){
                  return item_store_directory(directory: chosenList[index], index: index);
                },
              ),
            ) : Container(alignment: Alignment.center, child: Text('Danh sách trống', style: TextStyle(fontSize: 11),),),
          )
        ],
      ),
    );
  }
}