import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopAccount.dart';
import '../../../../Data/accountData/shopData/shopDirectory.dart';
import '../../../../Data/otherData/utils.dart';

class add_store_to_directory extends StatefulWidget {
  final shopDirectory directory;
  const add_store_to_directory({super.key, required this.directory});

  @override
  State<add_store_to_directory> createState() => _add_store_to_directoryState();
}

class _add_store_to_directoryState extends State<add_store_to_directory> {
  String query = '';
  final control = TextEditingController();
  List<ShopAccount> filteredList = [];
  final List<ShopAccount> list_restaurant = [];

  void get_restaurant_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Store").orderByChild('area').equalTo(widget.directory.area).onValue.listen((event) {
      list_restaurant.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ShopAccount account = ShopAccount.fromJson(value);
        if (widget.directory.restaurantList.contains(account.id)) {

        } else {
          list_restaurant.add(account);
          filteredList = list_restaurant.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
        }
      });
      setState(() {

      });
    });
  }

  Future<void> change_directory(shopDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('StoreDirectory').child(directory.id).set(directory.toJson());
      toastMessage('Thêm Shop thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_restaurant_data();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm Shop'),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        height: 200,
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Column(
            children: [
              TextField(
                controller: control,
                onChanged: (value) {
                  setState(() {
                    query = value;
                    filteredList = list_restaurant.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Tìm kiếm',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(filteredList[index].name),
                        onTap: () async {
                          control.text = filteredList[index].name;
                          widget.directory.restaurantList.add(filteredList[index].id);
                          await change_directory(widget.directory);
                          Navigator.of(context).pop();
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
    );
  }
}
