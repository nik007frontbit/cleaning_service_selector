import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import 'app_button.dart';
import 'bottom_sheet_title.dart';

Future<bool?> showDeleteConfirmationBottomSheet({required String title, required String message}) {
  return Get.bottomSheet<bool>(
    Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetTitle(title: title), // Assuming your own title widget
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  title: "Cancel",
                  textColor: AppColors.primary,
                  backColor: AppColors.whiteColor,
                  borderColor: AppColors.primary,
                  onTap: () => Get.back(result: false),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CommonButton(
                  title: "Delete",
                  backColor: AppColors.primary,
                  textColor: Colors.white,
                  onTap: () => Get.back(result: true),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    isDismissible: true,
    isScrollControlled: true,
  );
}
