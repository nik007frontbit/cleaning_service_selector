import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../widget/app_button.dart';
import '../../../widget/bottom_sheet_title.dart';
import '../controller/service_controller.dart';
import '../model/service_model.dart';

class SelectionBottomSheet extends StatelessWidget {
  SelectionBottomSheet({super.key, required this.services});

  /// Controller instance to manage services
  final ServiceController controller = Get.find();

  /// List of services passed from parent category
  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    /// Only show services that are currently unselected
    final unselectedServices = services.where((s) => !s.isSelected.value).toList();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75, // Max height 75% of screen
      ),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title of bottom sheet
          BottomSheetTitle(title: "Cart Settings"),
          const SizedBox(height: 16),

          // List of unselected services
          Expanded(
            child: Obx(() {
              // Wrapping in Obx ensures UI updates reactively when a service is selected
              return SingleChildScrollView(
                child: Column(
                  children: unselectedServices.map((service) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primary.withOpacity(0.4)),
                      ),
                      child: ListTile(
                        tileColor: AppColors.primary.withOpacity(0.1),
                        title: Text(service.name),
                        trailing: service.price != null
                            ? Text(
                                '\$${service.price!.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            : null,
                        leading: Checkbox(
                          value: service.isSelected.value,
                          activeColor: AppColors.primary,
                          onChanged: (val) {
                            controller.selectService(service);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ),

          // Confirm button closes bottom sheet
          CommonButton(
            onTap: () {
              Get.back();
            },
            isExpand: true,
            title: "Confirm",
            margin: const EdgeInsets.only(top: 8),
          ),
        ],
      ),
    );
  }
}
