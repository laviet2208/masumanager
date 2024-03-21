import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../../Data/otherData/utils.dart';

class lock_unlock_partner extends StatefulWidget {
  final ShopAccount account;
  const lock_unlock_partner({super.key, required this.account});

  @override
  State<lock_unlock_partner> createState() => _lock_unlock_partnerState();
}

class _lock_unlock_partnerState extends State<lock_unlock_partner> {

  Future<void> lock_unlock_restaurant(int status) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant').child(widget.account.id).child('lockStatus').set(status);
      toastMessage('Khóa/mở nhà hàng thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        child: Text('Khóa/mở tài khoản', style: TextStyle(color: Colors.blueAccent),),
        onPressed: () async {
          if (widget.account.lockStatus == 0) {
            await lock_unlock_restaurant(1);
          } else {
            await lock_unlock_restaurant(0);
          }
        },
      ),
    );
  }
}
