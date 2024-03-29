import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:masumanager/dataClass/FinalClass.dart';
import 'package:masumanager/dataClass/dataCheckManager.dart';

import '../../dataClass/Time.dart';
import '../../dataClass/accountShop.dart';
import '../../utils/utils.dart';
import '../Quản lý khu vực và tài khoản admin/Area.dart';
import '../Quản lý khu vực và tài khoản admin/Tài khoản admin khu vực/Page tìm kiếm.dart';
import 'Page tìm nhà hàng.dart';
import 'Voucher.dart';

class Themvoucher extends StatefulWidget {
  final double width;
  final double height;
  final int type;
  const Themvoucher({Key? key, required this.width, required this.height, required this.type}) : super(key: key);

  @override
  State<Themvoucher> createState() => _ThemvoucherState();
}

class _ThemvoucherState extends State<Themvoucher> {
  final tenchuongtrinhcontrol = TextEditingController();
  final macodecontrol = TextEditingController();
  final ngaybatdaucontrol = TextEditingController();
  final ngayketthuccontrol = TextEditingController();
  final sotiengiamcontrol = TextEditingController();
  final toithieugiamcontrol = TextEditingController();
  final toidacontrol = TextEditingController();
  final moikhachcontrol = TextEditingController();
  final toidatiencontrol = TextEditingController();
  bool loading = false;
  List<Area> areaList = [];
  List<accountShop> shopList = [];
  Area area = Area(id: '', name: '', money: 0, status: 0);
  final accountShop shop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 1, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, ListDirectory: [], Area: '', OpenStatus: 0);
  List<String> TypeList = ['Giảm theo tiền cứng', 'Giảm theo phần trăm'];
  String chosenType = 'Giảm theo tiền cứng';
  int Typeindex = 0;

  Future<void> _selectDate(BuildContext context) async {
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
        ngaybatdaucontrol.text = selectedDate.day.toString() + '/' + selectedDate.month.toString() + '/' + selectedDate.year.toString();
      });
    }
  }

  Future<void> _selectDate1(BuildContext context) async {
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
        ngayketthuccontrol.text = selectedDate.day.toString() + '/' + selectedDate.month.toString() + '/' + selectedDate.year.toString();
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

  void getData2() {
    final reference = FirebaseDatabase.instance.reference();
    reference.child("Restaurant").onValue.listen((event) {
      shopList.clear();
      final dynamic orders = event.snapshot.value;
      orders.forEach((key, value) {
        accountShop area= accountShop.fromJson(value);
        shopList.add(area);
      });
      setState(() {

      });
    });
  }

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      chosenType = selectedValue;
      if (chosenType == 'Giảm theo tiền cứng') {
        Typeindex = 0;
      } else {
        Typeindex = 1;
      }
    }
    setState(() {

    });
  }

  Future<void> pushData(Voucher voucher) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('VoucherStorage').child(voucher.id).set(voucher.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('đăng voucher thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  int extractData(String dateString,int index) {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      return int.tryParse(dateParts[index]) ?? 0;
    }
    return 0;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toidatiencontrol.text = '0';
    getData1();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    // chosenType = TypeList.first;
    return AlertDialog(
      title: Text((widget.type == 1) ? 'Thêm voucher khách hàng' : 'Thêm voucher nhà hàng'),
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
                      _selectDate(context);
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
                        controller: ngayketthuccontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
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
                          _selectDate1(context);
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
                Typeindex == 0 ? 'Số tiền giảm (Đơn vị : VNĐ)*' : 'Số phần trăm giảm (không có phần thập phân)*',
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
                        controller: sotiengiamcontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: Typeindex == 0 ? 'Số tiền cứng giảm (chỉ nhập số, không có các kí tự như . hoặc ,)*' : 'Số phần trăm giảm (không có phần thập phân , ví dụ 10 , 20 ,...)*',
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
              height: Typeindex == 1 ? 20 : 0,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Số tiền giảm tối đa(VNĐ)',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: Typeindex == 1 ? 14 : 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: Typeindex == 1 ? 10 : 0,
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: Typeindex == 1 ? 50 : 0,
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
                        controller: toidatiencontrol,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Typeindex == 1 ? 16 : 0,
                          fontFamily: 'muli',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Số tiền được trừ tối đa khi giảm theo phần trăm*',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: Typeindex == 1 ? 16 : 0,
                            fontFamily: 'muli',
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),

            Container(
              height: (widget.type == 1 && currentAccount.provinceCode == '0') ? 20 : 0,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                (widget.type == 1) ? 'Chọn khu vực' : 'Chọn nhà hàng',
                style: TextStyle(
                    fontFamily: 'muli',
                    fontSize: (widget.type == 1 && currentAccount.provinceCode == '0') ? 14 : 0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent
                ),
              ),
            ),

            Container(
              height: (widget.type == 1 && currentAccount.provinceCode == '0') ? 10 : 0,
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: (widget.type == 1 && currentAccount.provinceCode == '0') ? 150 : 0,
                child: (widget.type == 1) ? searchPageArea(list: areaList, area: area,) : searchResArea(list: shopList, shop: shop),
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

            if (tenchuongtrinhcontrol.text.isNotEmpty && macodecontrol.text.isNotEmpty && ngaybatdaucontrol.text.isNotEmpty && area.id != ''
                && ngayketthuccontrol.text.isNotEmpty && sotiengiamcontrol.text.isNotEmpty && toithieugiamcontrol.text.isNotEmpty && toidacontrol.text.isNotEmpty && moikhachcontrol.text.isNotEmpty) {
              if (dataCheckManager.isPositiveDouble(toithieugiamcontrol.text.toString()) && dataCheckManager.isPositiveDouble(sotiengiamcontrol.text.toString())
                  && dataCheckManager.isPositiveInteger(toidacontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngaybatdaucontrol.text.toString()) && dataCheckManager.isValidDateFormat(ngayketthuccontrol.text.toString())) {
                Voucher voucher = Voucher(
                  id: macodecontrol.text.toString(),
                  totalmoney: double.parse(sotiengiamcontrol.text.toString()),
                  mincost: double.parse(toithieugiamcontrol.text.toString()),
                  startTime: Time(second: 0, minute: 0, hour: 0, day: extractData(ngaybatdaucontrol.text.toString(),0), month: extractData(ngaybatdaucontrol.text.toString(),1), year: extractData(ngaybatdaucontrol.text.toString(),2)),
                  endTime: Time(second: 0, minute: 0, hour: 0, day: extractData(ngayketthuccontrol.text.toString(),0), month: extractData(ngayketthuccontrol.text.toString(),1), year: extractData(ngayketthuccontrol.text.toString(),2)),
                  useCount: 0,
                  maxCount: int.parse(toidacontrol.text.toString()),
                  tenchuongtrinh: tenchuongtrinhcontrol.text.toString(),
                  LocationId: area.id,
                  type: Typeindex,
                  Otype: widget.type.toString(),
                  perCustom: int.parse(moikhachcontrol.text.toString()),
                  CustomList: [],
                  maxSale: double.parse(toidatiencontrol.text.toString()),
                );
                await pushData(voucher);
                setState(() {
                  loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                });
                Navigator.of(context).pop();
              } else {
                toastMessage('Phải nhập đúng định dạng');
                setState(() {
                  loading = false; // Đặt biến loading lại thành false sau khi hoàn thành
                });
              }
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
