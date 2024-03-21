class provinceManager {
  static String getCityName(int number) {
    List<String> cityList = [
      "Hà Nội",
      "Hồ Chí Minh",
      "Hải Phòng",
      "Đà Nẵng",
      "Cần Thơ",
      "Hà Giang",
      "Cao Bằng",
      "Lai Châu",
      "Điện Biên",
      "Lào Cai",
      "Sơn La",
      "Yên Bái",
      "Tuyên Quang",
      "Lạng Sơn",
      "Bắc Kạn",
      "Thái Nguyên",
      "Hòa Bình",
      "Lạng Sơn",
      "Bắc Giang",
      "Quảng Ninh",
      "Phú Thọ",
      "Vĩnh Phúc",
      "Bắc Ninh",
      "Hải Dương",
      "Hưng Yên",
      "Thái Bình",
      "Hà Nam",
      "Nam Định",
      "Ninh Bình",
      "Thanh Hóa",
      "Nghệ An",
      "Hà Tĩnh",
      "Quảng Bình",
      "Quảng Trị",
      "Thừa Thiên-Huế",
      "Quảng Nam",
      "Quảng Ngãi",
      "Bình Định",
      "Phú Yên",
      "Khánh Hòa",
      "Ninh Thuận",
      "Bình Thuận",
      "Kon Tum",
      "Gia Lai",
      "Đắk Lắk",
      "Đắk Nông",
      "Lâm Đồng",
      "Bình Phước",
      "Tây Ninh",
      "Bình Dương",
      "Đồng Nai",
      "Bà Rịa-Vũng Tàu",
      "Long An",
      "Tiền Giang",
      "Bến Tre",
      "Trà Vinh",
      "Vĩnh Long",
      "Đồng Tháp",
      "An Giang",
      "Kiên Giang",
      "Cần Thơ",
      "Hậu Giang",
      "Sóc Trăng",
    ];

    if (number >= 1 && number <= cityList.length) {
      return cityList[number - 1];
    } else {
      return "Admin cao nhất";
    }
  }

  static String formatDoubleToString(double number) {
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }
}