import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/adsData/restaurantAdsData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:masumanager/MasuShipManager/mainManager/ads_manager/actions/delete_ads.dart';
import 'package:masumanager/MasuShipManager/mainManager/ads_manager/actions/edit_ads.dart';
import 'package:masumanager/MasuShipManager/mainManager/ads_manager/actions/on_off_ads.dart';
import '../shipper_manager/shipper_manager_main/action/upload_image.dart';

class item_ads extends StatefulWidget {
  final int index;
  final restaurantAdsData data;
  const item_ads({super.key, required this.index, required this.data});

  @override
  State<item_ads> createState() => _item_adsState();
}

class _item_adsState extends State<item_ads> {
  List<String> direction_list = ['Bật ra khi người dùng mở app','Xuất hiện trên đầu trang chính','Xuất hiện trong mục đồ ăn',];
  String area_name = '';
  String resName = '';
  String resPhone = '';

  Future<String> _getImageURL(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child('Ads').child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  }

  void get_area_info() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").child(widget.data.area).onValue.listen((event) {
      final dynamic area = event.snapshot.value;
      area_name = area['name'].toString();
      setState(() {

      });
    });
  }

  void get_res_info() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").child(widget.data.account.id).onValue.listen((event) {
      final dynamic area = event.snapshot.value;
      if (area != null) {
        resName = area['name'].toString();
        resPhone = area['phone'].toString();
        setState(() {

        });
      } else {
        deleteImage('Ads/' + widget.data.id + '.png');
        delete_ads();
      }

    });
  }

  void delete_ads() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Ads").child(widget.data.id).remove();
  }

  Future<void> deleteImage(String imagePath) async {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    try {
      await ref.delete();
      print('Xóa ảnh thành công: $imagePath');
    } catch (e) {
      print('Lỗi khi xóa ảnh: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_area_info();
    get_res_info();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    double height = 100;
    return Container(
      width: width,
      height: 150,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color.fromARGB(255, 247, 250, 255),
        border: Border.all(
          color: Color.fromARGB(255, 240, 240, 240),
          width: 1.0,
        ),
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 49,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Center(
                child: Text(
                  (widget.index + 1).toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Để in đậm
                  ),                ),
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 4,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Khu vực: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: area_name, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 5,),

                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      height: (width - 50)/5/5,
                      width: (width - 50)/5/2.5,
                      decoration: BoxDecoration(

                      ),
                      child: FutureBuilder(
                        future: _getImageURL(widget.data.id + '.png'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Ảnh lỗi hoặc chưa có ảnh',style: TextStyle(color: Colors.black, fontFamily: 'muli', fontSize: 13),textAlign: TextAlign.center,),
                            );                                                        }

                          if (!snapshot.hasData) {
                            return Text('Image not found');
                          }

                          return Image.network(snapshot.data.toString(),fit: BoxFit.fill,);
                        },
                      ),
                    ),
                  ),

                  Container(height: 3,),

                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(
                          'Chỉnh sửa ảnh',
                          style: TextStyle(
                              fontFamily: 'muli',
                              fontSize: 10,
                              color: Colors.blueAccent
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return upload_image(path: 'Ads/' + widget.data.id + '.png', title: 'Ảnh quảng cáo');
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Tên nhà tài trợ: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: resName, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Số điện thoại: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: resPhone, // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: Colors.purple,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Lần cuối khả dụng: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getAllTimeString(widget.data.pushTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Lần cuối dừng: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getAllTimeString(widget.data.endTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Lần cuối chỉnh sửa: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: getAllTimeString(widget.data.editTime), // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: Colors.black,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 8,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10,),
              child: ListView(
                children: [
                  Container(height: 8,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Xuất hiện tại vị trí: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: direction_list[widget.data.direction - 1], // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),

                  Container(
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Trạng thái: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              fontWeight: FontWeight.bold, // Để in đậm
                            ),
                          ),
                          TextSpan(
                            text: widget.data.status == 0 ? 'Không khả dụng' : 'Đang kích hoạt', // Phần còn lại viết bình thường
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'muli',
                              color: widget.data.status == 0 ? Colors.redAccent : Colors.green,
                              fontWeight: FontWeight.normal, // Để viết bình thường
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(height: 10,),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),

          Container(
            width: (width - 50)/5 - 1,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 20,),
              child: ListView(
                children: [
                  Container(height: 4,),

                  GestureDetector(
                    child: Container(
                      height: 27,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          'Xóa quảng cáo',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return delete_ads_dialog(data: widget.data);
                        },
                      );
                    },
                  ),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 27,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          'Cập nhật quảng cáo',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return edit_ads(data: widget.data);
                        },
                      );
                    },
                  ),

                  Container(height: 8,),

                  GestureDetector(
                    child: Container(
                      height: 27,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(
                          'Tắt/Bật quảng cáo',
                          style: TextStyle(
                            fontFamily: 'muli',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return on_off_ads(data: widget.data);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          Container(
            width: 1,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 226)
            ),
          ),
        ],
      ),
    );
  }
}
