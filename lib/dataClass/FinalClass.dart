import 'package:masumanager/Mainmanager/Qu%E1%BA%A3n%20l%C3%BD%20khu%20v%E1%BB%B1c%20v%C3%A0%20t%C3%A0i%20kho%E1%BA%A3n%20admin/Area.dart';
import 'package:masumanager/dataClass/Time.dart';
import 'package:masumanager/dataClass/accountShop.dart';
import 'package:masumanager/dataClass/adminaccount.dart';

final AdminAccount currentAccount = AdminAccount(username: '', password: '', isBlock: 1, permission: 1, provinceCode: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0),);
final accountShop currentShop = accountShop(openTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), ListDirectory: [], closeTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), phoneNum: '', location: '', name: '', id: '', status: 0, avatarID: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), password: '', isTop: 0, Type: 0, Area: '', OpenStatus: 0);
final Area currentArea = Area(id: '', name: '', money: 0, status: 0);

