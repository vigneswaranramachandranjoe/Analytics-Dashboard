
import 'package:flutter/material.dart';


import '../CONSTANT/app_colors.dart';
import '../CUSTOM_WIDGETS/custom_widgets.dart';



class AlertService {
  showSnackBar({context, msg, isEr}) async {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: CustomText(
        txt: msg.toString(),
        clr: Colors.white,
      ),
      backgroundColor: isEr == true ? Colors.red : Colors.green,
    ));
  }


  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(txt: "Confirm Logout",size: 18,fontWeight: FontWeight.bold,),
          content: CustomText(txt: "Are you Sure want to Logout?",size: 15,fontWeight: FontWeight.w700,),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: CustomText(txt: "No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child:  CustomText(txt: "Yes"),
            ),
          ],
        );
      },
    );
  }

}
