import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../widget/app_button.dart';
import '../../../widget/bottom_sheet_title.dart';

class CommonConfirmationBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonTitle;
  final VoidCallback confirmButtonAction;
  final String cancelButtonTitle;

  const CommonConfirmationBottomSheet({
    Key? key,
    required this.title,
    required this.message,
    required this.confirmButtonTitle,
    required this.confirmButtonAction,
    this.cancelButtonTitle = "Cancel",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetTitle(title: title),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  title: cancelButtonTitle,
                  textColor: AppColors.primary,
                  backColor: AppColors.whiteColor,
                  borderColor: AppColors.primary,
                  onTap: () => Get.back(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CommonButton(
                  title: confirmButtonTitle,
                  onTap: () {
                    Get.back();
                    confirmButtonAction();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
