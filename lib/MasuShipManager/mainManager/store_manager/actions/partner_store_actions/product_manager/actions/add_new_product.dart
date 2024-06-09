import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../../../../Data/accountData/shopData/Product.dart';
import '../../../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../../../Data/otherData/Tool.dart';
import '../../../../../../Data/otherData/utils.dart';

class add_new_product extends StatefulWidget {
  final ShopAccount account;
  const add_new_product({super.key, required this.account});

  @override
  State<add_new_product> createState() => _add_new_productState();
}

class _add_new_productState extends State<add_new_product> {
  Uint8List? registrationImage;
  bool loading = false;
  final nameController = TextEditingController();
  final describleController = TextEditingController();
  final costController = TextEditingController();

  Future<Uint8List?> galleryImagePicker() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String imageName) async {
    try {
      // Tạo tham chiếu đến Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child('Product/$imageName.png');

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

  Future<void> push_new_food(Product product) async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    await databaseRef.child('Product').child(product.id).set(product.toJson());
    setState(() {
      loading = false;
    });
    toastMessage('Thêm món thành công');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width/2.5,
        height: MediaQuery.of(context).size.height/5*4,
        child: ListView(
          children: [
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên sản phẩm *',
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
                          hintText: 'Tên sản phẩm',
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
                'Mô tả sản phẩm *',
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
                        controller: describleController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mô tả của sản phẩm',
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
                'Giá tiền sản phẩm(VNĐ) *',
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
                        controller: costController,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Giá tiền của sản phẩm',
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
                'Chọn ảnh đại diện sản phẩm*',
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
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator(color: Colors.black,) : TextButton(
          onPressed: () async {
            if (costController.text.isNotEmpty && nameController.text.isNotEmpty && describleController.text.isNotEmpty && registrationImage != null) {
              setState(() {
                loading = true;
              });
              Product product = Product(id: generateID(20), cost: double.parse(costController.text.toString()), name: nameController.text.toString(), describle: describleController.text.toString(), owner: widget.account.id, status: 0, createTime: getCurrentTime());
              await uploadImageToFirebaseStorage(registrationImage!, product.id);
              await push_new_food(product);
              setState(() {
                loading = false;
              });
              Navigator.of(context).pop();
            } else {
              toastMessage('Điền đủ thông tin');
            }

          },
          child: Text('Lưu', style: TextStyle(color: Colors.blueAccent),),
        ),

        loading ? CircularProgressIndicator(color: Colors.black,) : TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.redAccent),),
        ),
      ],
    );
  }
}
