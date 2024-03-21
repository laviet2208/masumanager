import 'Time.dart';

class AdminAccount {
  String username;
  String password;
  int isBlock; // 0 : đang mở , 1 : đang khóa
  int permission; // 1 : admin chính , 2 : admin các tỉnh
  Time createTime;
  String provinceCode;

  AdminAccount({required this.username, required this.password, required this.isBlock, required this.permission, required this.provinceCode, required this.createTime});

  Map<dynamic, dynamic> toJson() => {
    'username': username,
    'password': password,
    'isBlock' : isBlock,
    'permission' : permission,
    'provinceCode' : provinceCode,
    'createTime' : createTime.toJson()
  };

  factory AdminAccount.fromJson(Map<dynamic, dynamic> json) {
    return AdminAccount(
        username: json['username'].toString(),
        password: json['password'].toString(),
        isBlock: int.parse(json['isBlock'].toString()),
        permission: int.parse(json['permission'].toString()),
        provinceCode: json['provinceCode'].toString(),
        createTime: Time.fromJson(json['createTime']),
    );
  }

  void changeData(Map<dynamic, dynamic> json) {
    username = json['username'].toString();
    password = json['password'].toString();
    isBlock = int.parse(json['isBlock'].toString());
    permission = int.parse(json['permission'].toString());
    provinceCode = json['provinceCode'].toString();
    createTime = Time.fromJson(json['createTime']);
  }
}