import 'dart:math';

class dataCheckManager {
  static bool isPositiveDouble(String input) {
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

  static bool isPositiveInteger(String input) {
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

  static String generateRandomString(int n) {
    const String charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random random = Random();
    String result = "";

    for (int i = 0; i < n; i++) {
      int randomIndex = random.nextInt(charset.length);
      result += charset[randomIndex];
    }

    return result;
  }

  static bool isValidDateFormat(String input) {
    if (input == null || input.isEmpty) {
      return false;
    }

    // Sử dụng regular expression để kiểm tra định dạng ngày/tháng/năm
    final RegExp datePattern = RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');

    return datePattern.hasMatch(input);
  }

  //3 hàm convert từ dạng ngày/tháng/năm sang ỉnt
  static int extractDay(String dateString) {
    List<String> dateParts = dateString.split(':');
    if (dateParts.length == 3) {
      return int.tryParse(dateParts[0]) ?? 0;
    }
    return 0;
  }

  static int extractMonth(String dateString) {
    List<String> dateParts = dateString.split(':');
    if (dateParts.length == 3) {
      return int.tryParse(dateParts[1]) ?? 0;
    }
    return 0;
  }

  static int extractYear(String dateString) {
    List<String> dateParts = dateString.split(':');
    if (dateParts.length == 3) {
      return int.tryParse(dateParts[2]) ?? 0;
    }
    return 0;
  }


   static String getStringNumber(double number) {
    String result = number.toStringAsFixed(0); // làm tròn số
    result = result.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},'); // chuyển đổi phân tách hàng nghìn
    return result;
  }

  static String limitString(String input, int maxLength) {
    if (input.length <= maxLength) {
      return input;
    } else {
      // Cắt chuỗi đầu vào đến độ dài tối đa và thêm "..." vào cuối
      return input.substring(0, maxLength) + "...";
    }
  }

  static bool containsOnlyDigits(String input) {
    final RegExp digitRegex = RegExp(r'^[0-9]+$');
    return digitRegex.hasMatch(input);
  }

}