import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:masumanager/MasuShipManager/Data/otherData/utils.dart';

class upload_image extends StatefulWidget {
  final String path;
  final String title;
  const upload_image({Key? key, required this.path, required this.title}) : super(key: key);

  @override
  State<upload_image> createState() => _upload_imageState();
}

class _upload_imageState extends State<upload_image> {
  Uint8List? registrationImage;
  String Downloadurl = 'https://firebasestorage.googleapis.com/v0/b/xekoship-a0057.appspot.com/o/favicon.png?alt=media&token=4c3d22bf-971b-45af-9ebe-9561bd74d469';


  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes) async {
    try {
      // Tạo tham chiếu đến Firebase Storage
      Reference storageReference =
      FirebaseStorage.instance.ref().child(widget.path);

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

  Future<Uint8List?> galleryImagePicker() async {
    Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    return bytesFromPicker;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text(widget.title, style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'muli'),),
      content: Container(
        width: width/6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Container(
                height: width/6,
                width: width/6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
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

            Container(height: 10,),

            GestureDetector(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(
                    width: 0.5,
                    color: Colors.black
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Cập nhật ảnh',
                  style: TextStyle(
                    fontFamily: 'muli',
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              onTap: () async {
                if (registrationImage != null) {
                  await uploadImageToFirebaseStorage(registrationImage!);
                  Navigator.of(context).pop();
                } else {
                  toastMessage('Bạn chưa thêm ảnh');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
