import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/userAccount.dart';

class lock_open_user_dialog extends StatefulWidget {
  final UserAccount account;
  const lock_open_user_dialog({super.key, required this.account});

  @override
  State<lock_open_user_dialog> createState() => _lock_open_user_dialogState();
}

class _lock_open_user_dialogState extends State<lock_open_user_dialog> {
  bool loading = false;

  Future<void> changeLock(int status) async {
    final reference = FirebaseDatabase.instance.reference();
    await reference.child("Account").child(widget.account.id).child('lockStatus').set(status);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.account.lockStatus == 0 ? 'Xác nhận mở' : 'Xác nhận khóa'),
      actions: <Widget>[
        !loading ? TextButton(
          onPressed: () async {
            if (!loading) {
              if (widget.account.lockStatus == 0) {
                setState(() {
                  loading = true;
                });
                await changeLock(1);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              } else {
                setState(() {
                  loading = true;
                });
                await changeLock(0);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              }
            }
          },
          child: Text('Xác nhận', style: TextStyle(color: Colors.blueGrey),),
        ) : CircularProgressIndicator(color: Colors.blueAccent,),
      ],
    );
  }
}
