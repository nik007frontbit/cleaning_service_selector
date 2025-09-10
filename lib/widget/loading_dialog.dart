import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../config/app_colors.dart';
import '../config/app_images.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
          child: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).width / 3,
        width: MediaQuery.sizeOf(context).width / 3,
        child: Lottie.asset(
          AppImages.loadingLottie,
        ),
      )),
    );
  }
}

void showLoadingDialog() {
  Future.delayed(
    Duration.zero,
    () {
      Get.dialog(
        const LoadingView(),
        barrierDismissible: false,
        barrierColor: AppColors.whiteColor.withValues(alpha: 0.7),
      );
    },
  );
}

void hideLoadingDialog({
  bool isTrue = false,
}) {
  Get.back(
    closeOverlays: isTrue,
  );
}
