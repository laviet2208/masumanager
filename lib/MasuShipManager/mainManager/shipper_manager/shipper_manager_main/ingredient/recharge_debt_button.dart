import 'package:flutter/material.dart';
import 'package:masumanager/MasuShipManager/Data/accountData/shipperAccount.dart';
import 'package:masumanager/MasuShipManager/mainManager/shipper_manager/shipper_manager_main/action_dialog/recharge_debt_money.dart';

class recharge_debt_button extends StatelessWidget {
  final shipperAccount account;
  const recharge_debt_button({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border.all(
              width: 0.5,
              color: Colors.black,
            )
        ),
        alignment: Alignment.center,
        child: Text(
          'Nạp tiền ví ứng',
          style: TextStyle(
              fontFamily: 'muli',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return recharge_debt_money(account: account);
          },
        );
      },
    );
  }
}
