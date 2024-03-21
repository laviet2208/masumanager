import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';

class searchPageArea extends StatefulWidget {
  final List<Area> list;
  final Area area;
  const searchPageArea({Key? key, required this.list, required this.area,}) : super(key: key);

  @override
  State<searchPageArea> createState() => _searchPageState();
}

class _searchPageState extends State<searchPageArea> {
  String query = '';
  final control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Area> filteredList = widget.list.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
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
                      widget.area.name = filteredList[index].name;
                      widget.area.id = filteredList[index].id;
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