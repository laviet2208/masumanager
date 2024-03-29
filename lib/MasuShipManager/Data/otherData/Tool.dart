import 'dart:math';

import 'Time.dart';

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

//chuyển 1 biến time qua String dưới dạng giờ phút giây
String getTimeHour(Time time) {
  return (time.hour >= 10 ? time.hour.toString() : '0' + time.hour.toString()) + ":" + (time.minute >= 10 ? time.minute.toString() : '0' + time.minute.toString()) + ":" + (time.second >= 10 ? time.second.toString() : '0' + time.second.toString());
}

//chuyển 1 biến time qua String dưới dạng giờ phút giây ngày tháng năm
String getAllTimeString(Time time) {
  return (time.hour >= 10 ? time.hour.toString() : '0' + time.hour.toString()) + ":" + (time.minute >= 10 ? time.minute.toString() : '0' + time.minute.toString()) + ":" + (time.second >= 10 ? time.second.toString() : '0' + time.second.toString()) + " " + (time.day >= 10 ? time.day.toString() : '0' + time.day.toString()) + "/" + (time.month >= 10 ? time.month.toString() : '0' + time.month.toString()) + "/" + time.year.toString();
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

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
const double earthRadius = 6371; // Bán kính trái đất (đơn vị: km)

// Chuyển đổi độ từ độ sang radian
final double lat1Rad = lat1 * (pi / 180);
final double lon1Rad = lon1 * (pi / 180);
final double lat2Rad = lat2 * (pi / 180);
final double lon2Rad = lon2 * (pi / 180);

// Tính chênh lệch giữa kinh độ và vĩ độ
final double dLat = lat2Rad - lat1Rad;
final double dLon = lon2Rad - lon1Rad;

// Sử dụng công thức Haversine để tính khoảng cách
final double a = pow(sin(dLat / 2), 2) +
cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
final double distance = earthRadius * c;

return distance;
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