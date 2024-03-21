import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:masumanager/dataClass/accountShop.dart';

class searchResArea extends StatefulWidget {
  final List<accountShop> list;
  final accountShop shop;
  const searchResArea({Key? key, required this.list, required this.shop,}) : super(key: key);

  @override
  State<searchResArea> createState() => _searchPageState();
}

class _searchPageState extends State<searchResArea> {
  String query = '';
  final control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<accountShop> filteredList = widget.list.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          TextField(
            controller: control,
            onChanged: (value) {
              setState(() {
                query = value;
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
                    onTap: () {
                      control.text = filteredList[index].name;
                      widget.shop.name = filteredList[index].name;
                      widget.shop.id = filteredList[index].id;
                      widget.shop.Area = filteredList[index].Area;
                      setState(() {

                      });
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}