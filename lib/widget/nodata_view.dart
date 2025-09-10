import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/app_images.dart';
import 'app_button.dart';

class NoDataView extends StatelessWidget {
  Function() onTap;
  String buttonText;
  String titleText;
  bool isButtonNeed;
  String subTitleText;

  NoDataView({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.titleText,
    required this.subTitleText,
    this.isButtonNeed = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Load a Lottie file from your assets
              Lottie.asset(
                AppImages.noDataLottie,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Text(
                titleText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subTitleText,
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        )),
        Visibility(
          visible: isButtonNeed,
          child: CommonButton(
              onTap: onTap,
              title: buttonText,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              isExpand: true),
        )
      ],
    );
  }
}
