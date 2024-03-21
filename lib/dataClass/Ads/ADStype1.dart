import 'package:flutter/material.dart';

import '../accountShop.dart';

class ADStype1 {
  String id;
  String mainContent;
  String secondaryText;
  String mainImage;
  accountShop shop;

  ADStype1({required this.mainContent, required this.secondaryText, required this.mainImage, required this.shop, required this.id});

  Map<dynamic, dynamic> toJson() => {
    'mainContent': mainContent,
    'secondaryText': secondaryText,
    'mainImage' : mainImage,
    'shop' : shop.toJson(),
    'id' : id
  };

  factory ADStype1.fromJson(Map<dynamic, dynamic> json) {
    return ADStype1(
        mainContent: json['mainContent'].toString(),
        secondaryText: json['secondaryText'].toString(),
        mainImage: json['mainImage'].toString(),
        shop: accountShop.fromJson(json['shop']),
        id: json['id'].toString()
    );
  }
}