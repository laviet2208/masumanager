import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../Data/areaData/Area.dart';
import '../../../../Data/locationData/Location.dart';
import '../../../../Data/models/area_search/search_page_area.dart';
import '../../../../Data/otherData/Time.dart';
import '../../../../Data/otherData/Tool.dart';
import '../../../../Data/otherData/utils.dart';
import '../../../catch_order_manager/action/add_catch_order/location_pick_in_map.dart';

class add_partner_store extends StatefulWidget {
  const add_partner_store({super.key});

  @override
  State<add_partner_store> createState() => _add_partner_storeState();
}

class _add_partner_storeState extends State<add_partner_store> {
  bool loading = false;
  List<String> type_list = ['Thực phẩm', 'Rau củ', 'Mẹ và bé', 'Gia vị', 'Gia dụng', 'Đồ khô', 'Đồ hộp', 'Trứng sữa', 'Đồ nhậu'];
  String chosenStatus = '';
  ShopAccount account = ShopAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', phone: '', type: 0, password: '', closeTime: getCurrentTime(), openTime: getCurrentTime(), openStatus: 0, discount_type: 1, area: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), listDirectory: [], money: 0);
  TimeOfDay selectedTime = TimeOfDay.now();
  Uint8List? registrationImage;
  Area area = Area(id: '', name: '', money: 0, status: 0);
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final openController = TextEditingController();
  final closeController = TextEditingController();

  //Hàm chọn giờ
  Future<void> _selectTime(BuildContext context, Time time, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        time.hour = selectedTime.hour;
        time.minute = selectedTime.minute;
        controller.text = '${selectedTime.hour >= 10 ? selectedTime.hour.toString() : '0' + selectedTime.hour.toString()}:${selectedTime.minute >= 10 ? selectedTime.minute.toString() : '0' + selectedTime.minute.toString()}:00';
      });
    }
  }

  Future<Uint8List?> galleryImagePicker() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  Future<void> push_new_restaurant(ShopAccount account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store').child(account.id).set(account.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Thêm cửa hàng thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imageName) async {
    try {
      // Tạo tham chiếu đến Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('Store/$imageName.png');

      // Đặt loại (MIME type) là 'image/png'
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');

      // Upload dữ liệu của ảnh lên Firebase Storage với metadata
      UploadTask uploadTask = storageReference.putData(imageBytes, metadata);

      // Lắng nghe sự kiện khi upload hoàn thành
      await uploadTask.whenComplete(() => print('Upload completed'));
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void drop_down_status_restaurant(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      for (int i = 0; i < type_list.length; i++) {
        if (chosenStatus == type_list[i]) {
          account.type = i;
          break;
        }
      }
      setState(() {

      });
    }
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenStatus = type_list.first;
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm đối tác'),
      content: Container(
        width: MediaQuery.of(context).size.width/2.5,
        height: MediaQuery.of(context).size.width/3*2,
        child: ListView(
          children: [
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: nameController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên Shop',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
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
                'Loại Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                  child: DropdownButton<String>(
                    items: type_list.map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    )).toList(),
                    onChanged: (value) { drop_down_status_restaurant(value); },
                    value: chosenStatus,
                    iconEnabledColor: Colors.redAccent,
                    isExpanded: true,
                    iconDisabledColor: Colors.grey,
                  ),
                )
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số điện thoại Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: phoneController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số điện thoại cũng là tên đăng nhập',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
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
                'Mật khẩu Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: passwordController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập mật khẩu của Shop',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
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
                'Vị trí của Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
              child: location_pick_in_map(location: account.location),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Giờ mở cửa Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: openController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Click chọn giờ mở cửa',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                        onTap: () {
                          _selectTime(context,account.openTime,openController);
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
                'Giờ đóng cửa Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                        controller: closeController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Click chọn giờ đóng cửa',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                        onTap: () {
                          _selectTime(context,account.closeTime,closeController);
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
                'Chọn ảnh đại diện Shop*',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: 20,
            ),

            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width/8,
                  height: MediaQuery.of(context).size.width/8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 0.7,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child:registrationImage == null
                        ? Icon(Icons.image_outlined, size: 30.0, color: Colors.black,)
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
              height: 20,
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Khu vực của Shop *',
                style: TextStyle(
                    fontFamily: 'muli',
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
                height: 150,
                child: search_page_area(area: area,),
              ),
            ),

            Container(
              height: 20,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator() : TextButton(
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });

            if (nameController.text.isNotEmpty && passwordController.text.isNotEmpty && openController.text.isNotEmpty && area.id != ''
                && closeController.text.isNotEmpty && account.location.latitude != 0 && account.location.longitude != 0 && phoneController.text.isNotEmpty) {
              account.name = nameController.text.toString();
              account.phone = phoneController.text.toString();
              account.password = passwordController.text.toString();
              account.area = area.id;
              account.id = generateID(15);
              if (registrationImage != null) {
                await uploadImageToFirebaseStorage(registrationImage!, account.id);
              }
              await push_new_restaurant(account);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Phải nhập đủ thông tin');
              setState(() {
                loading = false;
              });
            }
          },
          child: Text(
            'Lưu Shop',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.blueAccent
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
                fontFamily: 'muli',
                color: Colors.redAccent
            ),
          ),
        ),
      ],
    );
  }
}
