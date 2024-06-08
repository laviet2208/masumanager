import 'package:masumanager/MasuShipManager/Data/otherData/Tool.dart';

import '../../Data/OrderData/catchOrder.dart';
import '../../Data/OrderData/catch_order_type_3_data/catchOrderType3.dart';
import '../../Data/OrderData/expressOrder/expressOrder.dart';
import '../../Data/OrderData/foodOrder/foodOrder.dart';
import '../../Data/OrderData/requestBuyOrderData/requestBuyOrder.dart';

class dashboard_controller {
  static double get_total_catch_income(List<CatchOrder> list) {
    double money = 0;
    for (CatchOrder order in list) {
      money = getShipDiscount(order.cost, order.costFee);
    }
    return money;
  }

  static double get_total_catch_3_income(List<catchOrderType3> list) {
    double money = 0;
    for (catchOrderType3 order in list) {
      money = getShipDiscount(order.cost, order.costFee);
    }
    return money;
  }

  static double get_total_express_income(List<expressOrder> list) {
    double money = 0;
    for (expressOrder order in list) {
      money = getShipDiscount(order.cost, order.costFee);
    }
    return money;
  }

  static double get_total_request_income(List<requestBuyOrder> list) {
    double money = 0;
    for (requestBuyOrder order in list) {
      money = getShipDiscount(order.cost, order.costFee);
    }
    return money;
  }

  static double get_total_food_income(List<foodOrder> list) {
    double money = 0;
    for (foodOrder order in list) {
      money = getShipDiscount(order.cost, order.costFee);
    }
    return money;
  }
}