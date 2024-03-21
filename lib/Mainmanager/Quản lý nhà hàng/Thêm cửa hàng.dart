import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20kh%C3%A1ch%20h%C3%A0ng/accountLocation.dart';
import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20nh%C3%A0%20h%C3%A0ng/Ch%E1%BB%8Dn%20v%E1%BB%8B%20tr%C3%AD%20tr%C3%AAn%20map/Ch%E1%BB%8Dn%20v%E1%BB%8B%20tr%C3%AD%20tr%C3%AAn%20map.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import 'DropList thể loại.dart';

class Themcuahang extends StatefulWidget {
  final double width;
  final double height;
  const Themcuahang({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  State<Themcuahang> createState() => _ThemcuahangState();
}

class _ThemcuahangState extends State<Themcuahang> {
  final tennhahangcontrol = TextEditingController();
  final sdtcontrol = TextEditingController();
  final locationcontrol = TextEditingController();
  final passcontrol = TextEditingController();
  final startcontrol = TextEditingController();
  final endcontrol = TextEditingController();
  Uint8List? registrationImage;
  int selectIndex = 0;
  String Downloadurl = 'https://firebasestorage.googleapis.com/v0/b/xekoship-a0057.appspot.com/o/favicon.png?alt=media&token=4c3d22bf-971b-45af-9ebe-9561bd74d469';
  bool loading = false;
  List<Area> areaList = [];
  TimeOfDay selectedTime = TimeOfDay.now();
  accountLocation location = accountLocation(phoneNum: '', LocationID: '', Latitude: 0, Longitude: 0, firstText: '', secondaryText: '');
  Area area = Area(id: '', name: '', money: 0, status: 0);
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 1);

  Future<Uint8List?> galleryImagePicker() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  Future<void> _selectTime(BuildContext context, int type) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        if (type == 1) {
          startcontrol.text =
          '${selectedTime.hour >= 10 ? selectedTime.hour.toString() : '0' + selectedTime.hour.toString()}:${selectedTime.minute >= 10 ? selectedTime.minute.toString() : '0' + selectedTime.minute.toString()}:00';
        } else {
          endcontrol.text =
          '${selectedTime.hour >= 10 ? selectedTime.hour.toString() : '0' + selectedTime.hour.toString()}:${selectedTime.minute >= 10 ? selectedTime.minute.toString() : '0' + selectedTime.minute.toString()}:00';
        }

      });
    }
  }

  void getData1() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Area").onValue.listen((event) {
      areaList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        Area area= Area.fromJson(value);
        areaList.add(area);
      });
      setState(() {

      });
    });
  }

  Future<void> pushData(accountShop accountShop) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Restaurant').child(accountShop.id).set(accountShop.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm nhà hàng thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imageName) async {
    try {
      // Tạo tham chiếu đến Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('Shop/$imageName.png');

      // Đặt loại (MIME type) là 'image/png'
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');

      // Upload dữ liệu của ảnh lên Firebase Storage với metadata
      UploadTask uploadTask = storageReference.putData(imageBytes, metadata);

      // Lắng nghe sự kiện khi upload hoàn thành
      await uploadTask.whenComplete(() => print('Upload completed'));

      // Lấy URL của ảnh từ Firebase Storage
      String imageUrl = await storageReference.getDownloadURL();
      Downloadurl = imageUrl;
      // In ra URL của ảnh
      print('Image URL: $imageUrl');
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm nhà hàng mới'),
      content: Container(
        width: widget.width * (1.5/3), // Đặt kích thước chiều rộng theo ý muốn
        height: widget.height * (2/3), // Đặt kích thước chiều cao theo ý muốn
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // màu của shadow
              spreadRadius: 5, // bán kính của shadow
              blurRadius: 7, // độ mờ của shadow
              offset: Offset(0, 3), // vị trí của shadow
            ),
          ],
        ),

        child: ListView(
          children: [
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: tennhahangcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên nhà hàng',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số điện thoại shop *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: sdtcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số điện thoại cũng là tên đăng nhập',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Vị trí của nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: PickLocationInMap(location: location, width: widget.width-20)
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Mật khẩu nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: passcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập mật khẩu của nhà hàng',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Giờ mở cửa nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: startcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Click chọn giờ mở cửa',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                        onTap: () {
                          _selectTime(context,1);
                          setState(() {

                          });
                        },
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Giờ đóng cửa nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      )
                  ),

                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Form(
                      child: TextFormField(
                        controller: endcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'arial',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Click chọn giờ đóng cửa',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'arial',
                          ),
                        ),
                        onTap: () {
                          _selectTime(context,2);
                          setState(() {

                          });
                        },
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn phân loại nhà hàng *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 10,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Droplistnhahang(width: widget.width * (1.5/3), shop: shop)
            ),

            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn khu vực quản lý *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: currentAccount.provinceCode == '0' ? 14 : 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: currentAccount.provinceCode == '0' ? 10 : 0,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: currentAccount.provinceCode == '0' ? 150 : 0,
                child: searchPageArea(list: areaList, area: area,),
              ),
            ),


            Container(
              height: currentAccount.provinceCode == '0' ? 10 : 0,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Nhập ảnh đại diện *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: (widget.width * (1.5/3))/2.5,right: (widget.width * (1.5/3))/2.5),
              child: GestureDetector(
                child: Container(
                  height: (widget.width * (1.5/3)) - ((widget.width * (1.5/3))/2.5)*2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child:registrationImage == null
                        ? Icon(Icons.add, size: 30.0, color: Colors.redAccent,)
                        : Image.memory(registrationImage!, fit: BoxFit.fitHeight,),
                  ),
                ),
                onTap: () async {
                  final Uint8List? image = await galleryImagePicker();

                  if (image != null) {
                    registrationImage = image;
                    setState(() {});
                  }
                },
              ),
            ),

            Container(
              height: 40,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: loading ? CircularProgressIndicator() : Text('Lưu'),
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });

            if (tennhahangcontrol.text.isNotEmpty && passcontrol.text.isNotEmpty && startcontrol.text.isNotEmpty && area.id != ''
                && endcontrol.text.isNotEmpty && location.Latitude != 0 && location.Longitude != 0 && sdtcontrol.text.isNotEmpty) {
              accountShop shop = accountShop(
                  openTime: Time(second: dataCheckManager.extractYear(startcontrol.text.toString()), minute: dataCheckManager.extractMonth(startcontrol.text.toString()), hour: dataCheckManager.extractDay(startcontrol.text.toString()), day: 0, month: 0, year: 0),
                  closeTime: Time(second: dataCheckManager.extractYear(endcontrol.text.toString()), minute: dataCheckManager.extractMonth(endcontrol.text.toString()), hour: dataCheckManager.extractDay(endcontrol.text.toString()), day: 0, month: 0, year: 0),
                  phoneNum: sdtcontrol.text.toString(),
                  location: location.Latitude.toString() + ',' + location.Longitude.toString(),
                  name: tennhahangcontrol.text.toString(),
                  id: dataCheckManager.generateRandomString(20),
                  status: 1,
                  avatarID: Downloadurl,
                  createTime: Time(second: DateTime.now().second, minute: DateTime.now().minute, hour: DateTime.now().hour, day: DateTime.now().day, month: DateTime.now().month, year: DateTime.now().year),
                  password: passcontrol.text.toString(),
                  isTop: 1,
                  Type: selectIndex, ListDirectory: [],
                  Area: currentAccount.provinceCode == '0' ? area.id : currentAccount.provinceCode, OpenStatus: 1);

              if (registrationImage != null) {
                await uploadImageToFirebaseStorage(registrationImage!, shop.id);
                shop.avatarID = Downloadurl;
              }
              await pushData(shop);
              setState(() {
                loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Phải nhập đủ thông tin');
              setState(() {
                loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
              });
            }
          },
        ),
      ],
    );
  }
}
