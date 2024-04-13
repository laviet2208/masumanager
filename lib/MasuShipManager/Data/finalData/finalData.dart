

import '../accountData/Account.dart';
import '../accountData/shipperAccount.dart';
import '../accountData/userAccount.dart';
import '../locationData/Location.dart';
import '../otherData/Time.dart';

class finalData {
  static Account account = UserAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
      location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),);

  static shipperAccount shipper_account = shipperAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
      location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''), onlineStatus: 0, money: 0, license: '', orderHaveStatus: 0);

  static UserAccount user_account = UserAccount(id: '', createTime: Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0), lockStatus: 0, name: '', area: '', phone: '',
    location: Location(placeId: '', description: '', longitude: 0, latitude: 0, mainText: '', secondaryText: ''),);
}