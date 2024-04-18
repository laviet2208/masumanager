import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/OrderData/expressOrder/expressOrder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class view_express_order_image extends StatefulWidget {
  final expressOrder order;
  const view_express_order_image({super.key, required this.order});

  @override
  State<view_express_order_image> createState() => _view_express_order_imageState();
}

class _view_express_order_imageState extends State<view_express_order_image> {
  bool loading = false;

  Future<String> _getImageURL() async {
    final ref = FirebaseStorage.instance.ref().child('expressImage').child(widget.order.id + '.png');
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: !loading ? Text(
          'Xem ảnh đơn',
          style: TextStyle(
              fontFamily: 'muli',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ) : CircularProgressIndicator(color: Colors.black,),
      ),
      onTap: () async {
        if (widget.order.status == 'D') {
          setState(() {
            loading = true;
          });
          String url = await _getImageURL();
          setState(() {
            loading = false;
          });
          if (await canLaunch(url)) {
            await launch(url, forceSafariVC: false, forceWebView: false);
          } else {
            throw 'Could not launch $url';
          }
        } else {
          toastMessage('Đơn không có ảnh');
        }
      },
    );
  }
}
