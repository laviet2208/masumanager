import 'package:flutter/material.dart';

import '../../dataClass/accountShop.dart';
class searchPagedanhmuc extends StatefulWidget {
  final List<String> list;
  final List<accountShop> list1;
  final VoidCallback event;
  const searchPagedanhmuc({Key? key, required this.list, required this.list1, required this.event}) : super(key: key);

  @override
  State<searchPagedanhmuc> createState() => _searchPageState();
}

class _searchPageState extends State<searchPagedanhmuc> {
  String query = '';
  final control = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<accountShop> filteredList = widget.list1.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
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
                      widget.list.add(filteredList[index].id);
                      widget.event();
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