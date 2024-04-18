import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masumanager/MasuShipManager/Data/finalData/finalData.dart';
import '../accountData/shopData/cartProduct.dart';
import '../costData/Cost.dart';
import '../locationData/Location.dart';
import '../voucherData/Voucher.dart';
import 'Time.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//Tool khởi tạo 1 chuỗi id ngẫu nhiên gồm count ký tự
String generateID(int count) {
  final character = "12CDEFGH3GH789ABCDEFGH";
  var returnString = "";
  final length = count;
  final random = Random();
  var text = List.generate(length, (index) => character[random.nextInt(character.length)]);

  for (var i = 0 ; i < text.length ; i++) {
    returnString += text[i];
  }

  return returnString;
}

//chuyển 1 biến time qua String dưới dạng ngày tháng năm
String getTimeString(Time time) {
  return time.day.toString() + "/" + time.month.toString() + "/" + time.year.toString();
}

String getTimeStringType1(Time time) {
  return (time.hour >= 10 ? time.hour.toString() : '0' + time.hour.toString()) + ":" + (time.minute >= 10 ? time.minute.toString() : '0' + time.minute.toString()) + ":" + (time.second >= 10 ? time.second.toString() : '0' + time.second.toString());
}

//chuyển 1 biến time qua String dưới dạng giờ phút giây ngày tháng năm
String getAllTimeString(Time time) {
  return (time.hour >= 10 ? time.hour.toString() : '0' + time.hour.toString()) + ":" + (time.minute >= 10 ? time.minute.toString() : '0' + time.minute.toString()) + " " + (time.day >= 10 ? time.day.toString() : '0' + time.day.toString()) + "/" + (time.month >= 10 ? time.month.toString() : '0' + time.month.toString()) + "/" + time.year.toString();
}

double getVoucherSale(Voucher voucher, double cost) {
  double money = 0;

  if(voucher.Money < 100) {
    double mn = cost * voucher.Money/100;
    if (mn <= voucher.maxSale) {
      money = mn;
    } else {
      money = voucher.maxSale;
    }
  } else {
    money = voucher.Money;
  }

  return money;
}

double getCosOfBike(double distance) {
  double cost = 0;
  if (distance >= finalData.bikeCost.departKM) {
    cost += finalData.bikeCost.departKM.toInt() * finalData.bikeCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
    distance -= finalData.bikeCost.departKM; // Trừ đi 2km đã tính giá cước
    cost = cost + ((distance - finalData.bikeCost.departKM) * finalData.bikeCost.perKMcost);
  } else {
    cost += (distance * finalData.bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
  }
  return cost;
}

bool isPositiveDouble(String input) {
  if (input == null) {
    return false;
  }

// Sử dụng try-catch để kiểm tra xem chuỗi có thể chuyển thành double không
  try {
    double.parse(input);
    return true;
  } catch (e) {
    return false;
  }
}

bool isPositiveInteger(String input) {
  if (input == null || input.isEmpty) {
    return false;
  }

// Sử dụng try-catch để kiểm tra xem chuỗi có thể chuyển thành số nguyên dương không
  try {
    int number = int.parse(input);
    return number > 0;
  } catch (e) {
    return false;
  }
}

double getDistanceOfBike(double cost, Cost bikeCost) {
  double distance = 0.0;
  if (cost >= (bikeCost.departKM * bikeCost.departCost)) {
    distance += bikeCost.departKM;
    double remainingCost = cost - (bikeCost.departKM * bikeCost.departCost);
    distance += remainingCost / bikeCost.perKMcost;
    distance = distance + bikeCost.departKM;
  } else {
    distance = cost / bikeCost.departCost;
  }
  return distance;
}

double get_total_cart_money(List<cartProduct> list) {
  double money = 0;
  for(int i = 0; i < list.length; i++) {
    money = money + (list[i].number * list[i].product.cost);
  }
  return money;
}

Future<double> getCostFuture(Location startLocation, Location endLocation, Cost bikeCost) async {
  double cost = 0;
  double distance = await getDistance(startLocation, endLocation);
  if (distance >= bikeCost.departKM) {
    cost += bikeCost.departKM.toInt() * bikeCost.departCost.toInt(); // Giá cước cho 2km đầu tiên (10.000 VND/km * 2km)
    distance -= bikeCost.departKM; // Trừ đi 2km đã tính giá cước
    cost = cost + ((distance - bikeCost.departKM) * bikeCost.perKMcost);
  } else {
    cost += (distance * bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
  }
//order.cost = cost;
  return cost;
}

double getCost(double distance, Cost bikeCost) {
  double cost = 0;
  if (distance >= bikeCost.departKM) {
    cost += bikeCost.departKM * bikeCost.departCost; // Giá cước cho km đề pa đầu tiên (10.000 VND/km * 2km)
    distance -= bikeCost.departKM; // Trừ đi số km đề pa đã tính giá cước
    cost = cost + ((distance - bikeCost.departKM) * bikeCost.perKMcost);
  } else {
    cost += (distance * bikeCost.departCost); // Giá cước cho khoảng cách dưới 2km
  }
  return cost;
}

//chuyển 1 biến double qua string , phân tách hàng nghìn
String getStringNumber(double number) {
  String result = number.toStringAsFixed(0); // làm tròn số
  result = result.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},'); // chuyển đổi phân tách hàng nghìn
  return result;
}

// //tính trung bình đánh giá , ép kiểu double
// double countRatedb(List<Evaluate> evaluate) {
//   if (evaluate.isEmpty) {
//     return 0.0;
//   } else {
//     int sum = 0;
//     for (int i = 0; i < evaluate.length; i++) {
//       sum += evaluate[i].star;
//     }
//     double avg = sum / evaluate.length;
//     return avg;
//   }
// }
//
// //tính trung bình đánh giá , ép kiểu string
// String countRate(List<Evaluate> evaluate) {
//   if (evaluate.isEmpty) {
//     return "0.0";
//   } else {
//     int sum = 0;
//     for (int i = 0; i < evaluate.length; i++) {
//       sum += evaluate[i].star;
//     }
//     double avg = sum / evaluate.length;
//     return avg.toStringAsFixed(1);
//   }
// }

//lấy số ngẫu nhiên
int get_randomnumber(int start, int end) { Random random = Random();
return start + random.nextInt(end - start + 1);
}

//rút gọn chuỗi
String compactString(int n, String str) {
  if (n >= str.length) {
    return str;
  }
  return str.substring(0, n) + "...";
}

bool compareTimes(Time time1, Time time2) {
  if (time1.year < time2.year) {
    return true;
  } else if (time1.year > time2.year) {
    return false;
  }

  if (time1.month < time2.month) {
    return true;
  } else if (time1.month > time2.month) {
    return false;
  }

  if (time1.day < time2.day) {
    return true;
  } else if (time1.day > time2.day) {
    return false;
  }

  if (time1.hour < time2.hour) {
    return true;
  } else if (time1.hour > time2.hour) {
    return false;
  }

  if (time1.minute < time2.minute) {
    return true;
  } else if (time1.minute > time2.minute) {
    return false;
  }

  if (time1.second < time2.second) {
    return true;
  }

  return false;
}


Time getCurrentTime() {
  DateTime now = DateTime.now();

  Time currentTime = Time(second: 0, minute: 0, hour: 0, day: 0, month: 0, year: 0);
  currentTime.second = now.second;
  currentTime.minute = now.minute;
  currentTime.hour = now.hour;
  currentTime.day = now.day;
  currentTime.month = now.month;
  currentTime.year = now.year;

  return currentTime;
}

bool isCurrentTimeInRange(DateTime openTime, DateTime closeTime) {
  DateTime currentTime = DateTime.now();
  openTime = DateTime(2000,1,1,openTime.hour,openTime.minute);
  closeTime = DateTime(2000,1,1,closeTime.hour,closeTime.minute);
  currentTime = DateTime(2000,1,1,currentTime.hour,currentTime.minute);
  print(currentTime.toString());
  // Kiểm tra xem currentTime có nằm trong khoảng openTime và closeTime không
  return currentTime.isAfter(openTime) && currentTime.isBefore(closeTime);
}

int get_number_restaurant(List<cartProduct> list) {
  Set<String> uniqueNames = Set<String>();

  for (cartProduct product in list) {
    uniqueNames.add(product.product.owner);
  }

  return uniqueNames.length;
}

Future<String> fetchLocationName(Location location) async {
  double latitude = location.latitude;
  double longitude = location.longitude;
  final Uri uri = Uri.parse('https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z');
  print('Url lỗi: ' + 'https://rsapi.goong.io/Geocode?latlng=$latitude,$longitude&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      location.mainText = data['results'][0]['formatted_address'];
      return data['results'][0]['formatted_address'];
    } else {
      throw Exception('Failed to load location');
    }
  } catch (e) {
    throw Exception('Lỗi khi xử lý dữ liệu: $e');
  }
}

Future<Cost> getBikecostFee(String areaID) async {
  final reference = FirebaseDatabase.instance.reference();
  DatabaseEvent snapshot = await reference.child('CostFee/' + areaID + '/Bike').once();
  final dynamic catchOrderData = snapshot.snapshot.value;
  Cost cost = Cost.fromJson(catchOrderData);
  return cost;
}


Future<double> getDistance(Location start, Location end) async {
  double startLatitude = start.latitude;
  double startLongitude = start.longitude;
  double endLatitude = end.latitude;
  double endLongitude = end.longitude;
  final url = Uri.parse("https://rsapi.goong.io/DistanceMatrix?origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&vehicle=bike&api_key=npcYThxwWdlxPTuGGZ8Tu4QAF7IyO3u2vYyWlV5Z");


  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final distance = data['rows'][0]['elements'][0]['distance']['value'];
      return distance.toDouble()/1000;
    } else {
      throw Exception('Lỗi khi gửi yêu cầu tới Goong API: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Lỗi khi xử lý dữ liệu: $e');
  }
}

BoxDecoration get_usually_decoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4), // màu của shadow
        spreadRadius: 2, // bán kính của shadow
        blurRadius: 7, // độ mờ của shadow
        offset: Offset(0, 3), // vị trí của shadow
      ),
    ],
  );
}

BoxDecoration get_usually_decoration_gradient() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.yellow.shade700 , Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 1.0],
    ),
  );
}

BoxDecoration get_usually_decoration_type_2_gradient() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.yellow , Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
    ),
  );
}

