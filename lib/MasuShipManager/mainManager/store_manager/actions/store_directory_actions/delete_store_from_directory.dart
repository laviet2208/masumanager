import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopDirectory.dart';

import '../../../../Data/otherData/utils.dart';

class delete_store_from_directory extends StatefulWidget {
  final String deleteId;
  final shopDirectory directory;
  const delete_store_from_directory({super.key, required this.deleteId, required this.directory});

  @override
  State<delete_store_from_directory> createState() => _delete_store_from_directoryState();
}

class _delete_store_from_directoryState extends State<delete_store_from_directory> {
  bool loading = false;
  Future<void> change_directory(shopDirectory directory) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('StoreDirectory').child(directory.id).set(directory.toJson());
      toastMessage('Sửa danh mục thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Xóa khỏi danh mục'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            widget.directory.restaurantList.remove(widget.deleteId);
            await change_directory(widget.directory);
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
          },
          child: Text('Đồng ý', style: TextStyle(color: Colors.blueAccent),),
        ),
      ],
    );
  }
}
