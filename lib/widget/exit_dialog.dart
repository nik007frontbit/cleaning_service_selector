import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';
import 'app_button.dart';

AlertDialog exitDialog() {
  return AlertDialog(
    contentPadding: const EdgeInsets.all(0),
    titlePadding: const EdgeInsets.all(0),
    title: Center(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          'Exit App',
          style: AppTextStyle.regular600.copyWith(fontSize: 20),
        ),
      ),
    ),
    // content: Center(child: const Text('Are you sure you want to Exit?')),
    actions: <Widget>[
      Center(
        child: Container(
          margin: const EdgeInsets.only(top: 8, bottom: 16),
          child: Text(
            'Are you sure you want to Exit?',
            style: AppTextStyle.regular500,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CommonButton(
              title: "Cancel",
              margin: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
              backColor: AppColors.primary,
              onTap: () {
                Get.back();
              },
              // buttonPadding:
              // EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
            ),
          ),
          Expanded(
            child: CommonButton(
              title: "Exit",
              margin: const EdgeInsets.only(right: 8, left: 8, bottom: 8),

              // buttonPadding:
              // EdgeInsets.only(top: 8, bottom: 8, right: 32, left: 32),
              backColor: AppColors.primary,
              onTap: () async {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          )
        ],
      )
      // TextButton(
      //   onPressed: () {
      //   },
      //   child: const Text('CANCEL'),
      // ),
      // TextButton(
      //   onPressed: () async {
      //   },
      //   child: const Text('OKAY'),
      // ),
    ],
  );
}
