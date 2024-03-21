import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopAccount.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../../Data/areaData/Area.dart';
import '../../../../../Data/models/area_search/search_page_area.dart';
import '../../../../../Data/otherData/utils.dart';
import '../../../../catch_order_manager/action/add_catch_order/location_pick_in_map.dart';

class edit_location_area extends StatefulWidget {
  final ShopAccount account;
  const edit_location_area({super.key, required this.account});

  @override
  State<edit_location_area> createState() => _edit_location_areaState();
}

class _edit_location_areaState extends State<edit_location_area> {
  bool loading = false;
  Area area = Area(id: '', name: '', money: 0, status: 0);

  Future<void> change_restaurant(ShopAccount account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant').child(account.id).set(account.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm nhà hàng thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chỉnh sửa vị trí'),
      content: Container(
        width: MediaQuery.of(context).size.width/2.5,
        height: MediaQuery.of(context).size.height/2,
        child: ListView(
          children: [
            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Vị trí của nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
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
              child: location_pick_in_map(location: widget.account.location),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Khu vực của nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
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
                height: 150,
                child: search_page_area(area: area,),
              ),
            ),

            Container(
              height: 20,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator() : TextButton(
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });

            if (widget.account.location.latitude != 0 && widget.account.location.longitude != 0) {
              await change_restaurant(widget.account);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Phải nhập đủ thông tin');
              setState(() {
                loading = false;
              });
            }
          },
          child: Text(
            'Lưu nhà hàng',
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
