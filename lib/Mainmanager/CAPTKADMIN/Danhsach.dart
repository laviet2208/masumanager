import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../dataClass/adminaccount.dart';

class Danhsachadmin extends StatefulWidget {
  final double width;
  final double height;
  const Danhsachadmin({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Danhsachadmin> createState() => _DanhsachadminState();
}

class _DanhsachadminState extends State<Danhsachadmin> {
  List<AdminAccount> adminList = [];
  void getData() {
    final reference = FirebaseDatabase.instance. reference();
    reference.child("ADMINaccount").onValue.listen((event) {
      adminList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        AdminAccount food= AdminAccount.fromJson(value);
        adminList.add(food);
      });
      setState(() {

      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
