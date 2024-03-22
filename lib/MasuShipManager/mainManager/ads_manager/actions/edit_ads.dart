import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/adsData/restaurantAdsData.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../Data/accountData/shopData/shopAccount.dart';
import '../../../Data/otherData/utils.dart';

class edit_ads extends StatefulWidget {
  final restaurantAdsData data;
  const edit_ads({super.key, required this.data});

  @override
  State<edit_ads> createState() => _edit_adsState();
}

class _edit_adsState extends State<edit_ads> {
  bool loading = false;
  String query = '';
  final control = TextEditingController();
  List<ShopAccount> filteredList = [];
  final List<ShopAccount> list_shop = [];
  String chosenDirection = "";
  List<String> direction_list = ['Bật ra khi mở app','Trên đầu trang chính','Trong mục đồ ăn',];

  void get_shop_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      list_shop.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ShopAccount area= ShopAccount.fromJson(value);
        list_shop.add(area);
        filteredList = list_shop.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
      setState(() {

      });
    });
  }

  Future<void> push_ads() async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Ads').child(widget.data.id).set(widget.data.toJson());
      toastMessage('Cập nhật ads thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void drop_down_direction(String? selectedValue) {
    if (selectedValue is String) {
      chosenDirection = selectedValue;
      for (int i = 0; i < direction_list.length; i++) {
        if (chosenDirection == direction_list[i]) {
          widget.data.direction = i + 1;
          break;
        }
      }
      setState(() {

      });
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_shop_data();
    chosenDirection = direction_list[widget.data.direction - 1];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm quảng cáo mới', style: TextStyle(fontFamily: 'roboto', fontSize: 14),),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height/3*2,
        child: ListView(
          children: [
            Container(height: 4,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn nhà hàng tài trợ cho ads *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    TextField(
                      controller: control,
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          filteredList = list_shop.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Tìm kiếm nhà tài trợ',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(filteredList[index].name),
                              onTap: () {
                                control.text = filteredList[index].name + ' - ' + filteredList[index].phone;
                                widget.data.account.id = filteredList[index].id;
                                widget.data.account.area = filteredList[index].area;
                                widget.data.area = filteredList[index].area;
                                toastMessage('Chọn nhà hàng thành công');
                                setState(() {

                                });
                              }
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn nơi xuất hiện trong app của ads *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(height: 10,),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: DropdownButton<String>(
                    items: direction_list.map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    )).toList(),
                    onChanged: (value) { drop_down_direction(value); },
                    value: chosenDirection,
                    iconEnabledColor: Colors.redAccent,
                    isExpanded: true,
                    iconDisabledColor: Colors.grey,
                  ),
                )
            ),

            Container(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator() : TextButton(
          onPressed: loading ? null : () async {
            if (widget.data.account.id != '') {
              setState(() {
                loading = true;
              });
              await push_ads();
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Nhập đủ thông tin trước');
            }
          },
          child: Text(
            'Cập nhật',
            style: TextStyle(
                fontFamily: 'roboto',
                color: Colors.blueAccent
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
                fontFamily: 'roboto',
                color: Colors.redAccent
            ),
          ),
        ),
      ],
    );
  }
}
