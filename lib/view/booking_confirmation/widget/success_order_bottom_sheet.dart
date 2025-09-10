import 'package:cleaning_service_selector/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/app_button.dart';
import '../../../widget/bottom_sheet_title.dart';
import '../../service_selection/controller/service_controller.dart';

class SuccessOrderBottomSheet extends StatelessWidget {
  const SuccessOrderBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Limit the height of the bottom sheet to 75% of screen height
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bottom sheet title
          BottomSheetTitle(title: "Cart Settings"),
          const SizedBox(height: 16),

          // Success icon
          Icon(Icons.check_circle, color: AppColors.greenColor, size: 80),
          const SizedBox(height: 20),

          // Confirmation text
          Text(
            "Service Confirm Successfully",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text('If you are not happy it is free. No questions asked.'),
          const SizedBox(height: 10),

          // Continue button
          CommonButton(
            onTap: () {
              // Get the controller and reset all selections
              final ServiceController controller = Get.find();
              controller.resetSelections();

              // Close both bottom sheets/screens
              Get.back(); // closes this bottom sheet
              Get.back(); // goes back to previous screen
            },
            isExpand: true,
            title: "Continue",
            margin: const EdgeInsets.only(top: 8),
          ),
        ],
      ),
    );
  }
}

