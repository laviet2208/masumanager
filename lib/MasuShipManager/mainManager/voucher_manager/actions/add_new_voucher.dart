import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/models/area_search/search_page_area.dart';
import 'package:masumanager/MasuShipManager/Data/voucherData/Voucher.dart';
import '../../../Data/areaData/Area.dart';
import '../../../Data/otherData/Time.dart';
import '../../../Data/otherData/Tool.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../Data/otherData/utils.dart';

class add_new_voucher extends StatefulWidget {
  const add_new_voucher({super.key});

  @override
  State<add_new_voucher> createState() => _add_new_voucherState();
}

class _add_new_voucherState extends State<add_new_voucher> {
  final tenchuongtrinhcontrol = TextEditingController();
  final macodecontrol = TextEditingController();
  final ngaybatdaucontrol = TextEditingController();
  final ngayketthuccontrol = TextEditingController();
  final sotiengiamcontrol = TextEditingController();
  final toithieugiamcontrol = TextEditingController();
  final toidacontrol = TextEditingController();
  final moikhachcontrol = TextEditingController();
  final toidatiencontrol = TextEditingController();

  List<String> TypeList = ['Giảm theo phần trăm', 'Giảm theo tiền cứng',];
  String chosenType = '';
  
  bool loading = false;
  Area area = Area(id: '', name: '', money: 0, status: 0);
  Voucher voucher = Voucher(id: '', Money: 0, mincost: 0, startTime: getCurrentTime(), endTime: getCurrentTime(), useCount: 0, maxCount: 0, eventName: '', LocationId: '', type: 0, Otype: '', perCustom: 1, CustomList: [], maxSale: 0, area: '');
  
  //Sự kiện chọn loại voucher
  int typeIndex = 0;
  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      chosenType = selectedValue;
      if (chosenType == 'Giảm theo phần trăm') {
        typeIndex = 0;
      } else {
        typeIndex = 1;
      }
    }
    setState(() {

    });
  }
  
  // hàm chọn ngày
  Future<void> _selectDate(BuildContext context, TextEditingController controller, Time time) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        time.day = selectedDate.day;
        time.month = selectedDate.month;
        time.year = selectedDate.year;
        controller.text = selectedDate.day.toString() + '/' + selectedDate.month.toString() + '/' + selectedDate.year.toString();
      });
    }
  }

  Future<void> push_voucher_data(Voucher voucher) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('VoucherStorage').child(voucher.id).set(voucher.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('đăng voucher thành công');
    } catch (error) {
      toastMessage('Lỗi dữ liệu');
      Navigator.of(context).pop();
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chosenType = TypeList.first;
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(
        'Thêm voucher mới',
        style: TextStyle(fontFamily: 'muli',),
      ),
      content: Container(
        width: width/2,
        height: height/3*2,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Tên chương trình *',
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
                      borderRadius: BorderRadius.circular(0),
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
                        controller: tenchuongtrinhcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tên chương trình',
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
                'Mã code *',
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
                      borderRadius: BorderRadius.circular(0),
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
                        controller: macodecontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mã code',
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
                'Ngày bắt đầu *',
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
                  borderRadius: BorderRadius.circular(0),
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
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: ngaybatdaucontrol,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'muli',
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nhấn chọn ngày bắt đầu',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: 'muli',
                      ),
                    ),
                    onTap: () {
                      _selectDate(context, ngaybatdaucontrol, voucher.startTime);
                    },
                  ),
                ),
              ),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Ngày kết thúc *',
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
                      borderRadius: BorderRadius.circular(0),
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
                        controller: ngayketthuccontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhấn chọn ngày kết thúc',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: 'muli',
                          ),
                        ),
                        onTap: () {
                          _selectDate(context, ngayketthuccontrol, voucher.endTime);
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
                'Áp dụng cho đơn từ *',
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
                      borderRadius: BorderRadius.circular(0),
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
                        controller: toithieugiamcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Áp dụng cho đơn từ(VNĐ - chỉ nhập mình số)',
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
                'Số lượng tối đa *',
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
                      borderRadius: BorderRadius.circular(0),
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
                        controller: toidacontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Tối đa',
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
                'Số lượng tối đa mỗi khách*',
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
                      borderRadius: BorderRadius.circular(0),
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
                        controller: moikhachcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số lần tối đa mỗi khách',
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
                'Kiểu giảm giá *',
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
              child: DropdownButton<String>(
                items: TypeList.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                )).toList(),
                onChanged: (value) { dropdownCallback(value); },
                value: chosenType,
                iconEnabledColor: Colors.redAccent,
                isExpanded: true,
                iconDisabledColor: Colors.grey,
              ),
            ),

            Container(
              height: 20,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                typeIndex == 1 ? 'Số tiền giảm (Đơn vị : VNĐ)*' : 'Số phần trăm giảm (không có phần thập phân)*',
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
                      borderRadius: BorderRadius.circular(0),
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
                        controller: sotiengiamcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: typeIndex == 1 ? 'Số tiền cứng giảm (chỉ nhập số, không có các kí tự như . hoặc ,)*' : 'Số phần trăm giảm (không có phần thập phân , ví dụ 10 , 20 ,...)*',
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
              height: typeIndex == 0 ? 20 : 0,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số tiền giảm tối đa(VNĐ)',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: typeIndex == 0 ? 14 : 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: typeIndex == 0 ? 10 : 0,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: typeIndex == 0 ? 50 : 0,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
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
                        controller: toidatiencontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: typeIndex == 0 ? 16 : 0,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số tiền được trừ tối đa khi giảm theo phần trăm*',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: typeIndex == 0 ? 16 : 0,
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
                'Chọn khu vực',
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
                child: search_page_area(area: area),
              ),
            ),

            Container(
              height: 40,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator(color: Colors.blueAccent,) : TextButton(
          onPressed: () async {
            if (tenchuongtrinhcontrol.text.isNotEmpty && macodecontrol.text.isNotEmpty && ngaybatdaucontrol.text.isNotEmpty && area.id != '' && ngayketthuccontrol.text.isNotEmpty && sotiengiamcontrol.text.isNotEmpty && toithieugiamcontrol.text.isNotEmpty && toidacontrol.text.isNotEmpty && moikhachcontrol.text.isNotEmpty && area.id != '') {
              if (isPositiveDouble(toithieugiamcontrol.text.toString()) && isPositiveDouble(sotiengiamcontrol.text.toString()) && isPositiveInteger(toidacontrol.text.toString())) {
                setState(() {
                  loading = true;
                });
                voucher.eventName = tenchuongtrinhcontrol.text.toString();
                voucher.id = macodecontrol.text.toString();
                voucher.area = area.id;
                voucher.type = typeIndex;
                voucher.Money = double.parse(sotiengiamcontrol.text.toString());
                voucher.mincost = double.parse(toithieugiamcontrol.text.toString());
                if (toidatiencontrol.text.isNotEmpty) {
                  voucher.maxSale = double.parse(toidatiencontrol.text.toString());
                }
                voucher.perCustom = int.parse(moikhachcontrol.text.toString());
                voucher.maxCount = int.parse(toidacontrol.text.toString());
                await push_voucher_data(voucher);
                setState(() {
                  loading = false;
                });
                Navigator.of(context).pop();
              } else {
                toastMessage('Chú ý đúng định dạng');
              }
            } else {
              toastMessage('Chú ý đúng định dạng');
            }

          },
          child: Text(
            'Thêm voucher mới',
            style: TextStyle(
                fontFamily: 'arial',
                color: Colors.blueAccent
            ),
          ),
        ),

        loading ? CircularProgressIndicator(color: Colors.redAccent,) : TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
                fontFamily: 'arial',
                color: Colors.redAccent
            ),
          ),
        ),
      ],
    );
  }
}
