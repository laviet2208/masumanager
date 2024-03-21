import 'package:flutter/material.dart';

import '../../dataClass/accountShop.dart';
class searchPage extends StatefulWidget {
  final List<accountShop> list;
  final accountShop selectShop;
  const searchPage({Key? key, required this.list, required this.selectShop}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
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
                    widget.selectShop.name = filteredList[index].name;
                    widget.selectShop.id = filteredList[index].id;
                    widget.selectShop.phoneNum = filteredList[index].phoneNum;
                    widget.selectShop.Area = filteredList[index].Area;
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
