import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shopData/shopAccount.dart';
import 'package:masumanager/MasuShipManager/Data/adsData/restaurantAdsData.dart';
import 'dart:typed_data';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:masumanager/MasuShipManager/Data/locationData/Location.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';


class add_new_ads extends StatefulWidget {
  const add_new_ads({super.key});

  @override
  State<add_new_ads> createState() => _add_new_adsState();
}

class _add_new_adsState extends State<add_new_ads> {
  bool loading = false;
  String query = '';
  final control = TextEditingController();
  List<ShopAccount> filteredList = [];
  final List<ShopAccount> list_shop = [];
  Uint8List? registrationImage;
  String chosenDirection = "";
  List<String> direction_list = ['Bật ra khi mở app','Trên đầu trang chính','Trong mục đồ ăn','Trong mục shop',];
  restaurantAdsData data = restaurantAdsData(id: '', account: ShopAccount(id: '', createTime: getCurrentTime(), lockStatus: 0, name: '', phone: '', money: 0, type: 0, password: '', closeTime: getCurrentTime(), openTime: getCurrentTime(), openStatus: 0, discount_type: 0, area: '', location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), listDirectory: []), area: '', status: 0, direction: 1, editTime: getCurrentTime(), pushTime: getCurrentTime(), endTime: getCurrentTime());

  void get_shop_data() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      list_shop.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        ShopAccount area= ShopAccount.fromJson(value);
        list_shop.add(area);
        filteredList = list_shop.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
      setState(() {

      });
    });
  }

  Future<Uint8List?> galleryImagePicker() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imageName) async {
    try {
      // Tạo tham chiếu đến Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('Ads/$imageName.png');

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

  Future<void> push_new_ads(restaurantAdsData data) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Ads').child(data.id).set(data.toJson());
      toastMessage('Thêm ads thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void drop_down_direction(String? selectedValue) {
    if (selectedValue is String) {
      chosenDirection = selectedValue;
      for (int i = 0; i < direction_list.length; i++) {
        if (chosenDirection == direction_list[i]) {
          data.direction = i + 1;
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
    get_shop_data();
    chosenDirection = direction_list.first;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm quảng cáo mới', style: TextStyle(fontFamily: 'muli', fontSize: 14),),
      content: Container(
        width: MediaQuery.of(context).size.width/3,
        height: MediaQuery.of(context).size.height/3*2,
        child: ListView(
          children: [
            Container(height: 4,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn nhà hàng tài trợ cho ads *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Column(
                  children: [
                    TextField(
                      controller: control,
                      onChanged: (value) {
                        setState(() {
                          query = value;
                          filteredList = list_shop.where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Tìm kiếm nhà tài trợ',
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
                                control.text = filteredList[index].name + ' - ' + filteredList[index].phone;
                                data.account.id = filteredList[index].id;
                                data.account.area = filteredList[index].area;
                                data.area = filteredList[index].area;
                                toastMessage('Chọn nhà hàng thành công');
                                setState(() {

                                });
                              }
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn nơi xuất hiện trong app của ads *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(height: 10,),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: DropdownButton<String>(
                    items: direction_list.map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    )).toList(),
                    onChanged: (value) { drop_down_direction(value); },
                    value: chosenDirection,
                    iconEnabledColor: Colors.redAccent,
                    isExpanded: true,
                    iconDisabledColor: Colors.grey,
                  ),
                )
            ),

            Container(height: 20,),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Chọn ảnh đại diện cho ads *',
                style: TextStyle(
                    fontFamily: 'arial',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(height: 10,),

            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width/7,
                  height: MediaQuery.of(context).size.width/14,
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
                        : Image.memory(registrationImage!, fit: BoxFit.fill,),
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

            Container(height: 10,),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator() : TextButton(
          onPressed: loading ? null : () async {
            if (data.account.id != '' && registrationImage != null) {
              setState(() {
                loading = true;
              });
              data.id = generateID(15);
              data.editTime = getCurrentTime();
              data.pushTime = getCurrentTime();
              await uploadImageToFirebaseStorage(registrationImage!, data.id);
              await push_new_ads(data);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Nhập đủ thông tin trước');
            }
          },
          child: Text(
            'Thêm ads mới',
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
