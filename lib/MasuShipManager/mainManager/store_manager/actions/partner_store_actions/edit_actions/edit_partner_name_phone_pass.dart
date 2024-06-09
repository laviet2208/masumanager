import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../../../Data/accountData/shopData/shopAccount.dart';
import '../../../../../Data/otherData/utils.dart';

class edit_partner_name_phone_pass extends StatefulWidget {
  final ShopAccount account;
  const edit_partner_name_phone_pass({super.key, required this.account});

  @override
  State<edit_partner_name_phone_pass> createState() => _edit_partner_name_phone_passState();
}

class _edit_partner_name_phone_passState extends State<edit_partner_name_phone_pass> {
  bool loading = false;
  List<String> type_list = ['Thực phẩm', 'Rau củ', 'Mẹ và bé', 'Gia vị', 'Gia dụng', 'Đồ khô', 'Đồ hộp', 'Trứng sữa', 'Đồ nhậu'];
  String chosenStatus = '';
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> edit_restaurant(ShopAccount account) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('Store').child(account.id).set(account.toJson());
      setState(() {
        loading = false;
      });
      toastMessage('Sửa Shop thành công');
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  void drop_down_status_restaurant(String? selectedValue) {
    if (selectedValue is String) {
      chosenStatus = selectedValue;
      for (int i = 0; i < type_list.length; i++) {
        if (chosenStatus == type_list[i]) {
          widget.account.type = i;
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
    nameController.text = widget.account.name;
    phoneController.text = widget.account.phone;
    passwordController.text = widget.account.password;
    chosenStatus = type_list[widget.account.type];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Sửa thông tin'),
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

          ],
        ),
      ),
      actions: <Widget>[
        loading ? CircularProgressIndicator() : TextButton(
          onPressed: loading ? null : () async {
            setState(() {
              loading = true;
            });

            if (nameController.text.isNotEmpty && passwordController.text.isNotEmpty && phoneController.text.isNotEmpty) {
              widget.account.name = nameController.text.toString();
              widget.account.phone = phoneController.text.toString();
              widget.account.password = passwordController.text.toString();
              await edit_restaurant(widget.account);
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
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: Text(
            'Hủy',
            style: TextStyle(
                color: Colors.redAccent
            ),
          ),
        ),
      ],
    );
  }
}
