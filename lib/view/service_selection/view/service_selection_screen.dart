import 'package:cleaning_service_selector/config/app_colors.dart';
import 'package:cleaning_service_selector/widget/app_button.dart';
import 'package:cleaning_service_selector/widget/common_snackbar.dart';
import 'package:cleaning_service_selector/widget/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../booking_confirmation/view/booking_confirmation_screen.dart';
import '../controller/service_controller.dart';
import '../widget/selection_bottom_sheet.dart';

class ServiceSelectionScreen extends StatelessWidget {
  const ServiceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller for managing services, counts, and date/time
    final controller = Get.put(ServiceController());

    // Categories for services
    List<String> categories = ['Standard', 'Deep Cleaning', 'Add-Ons'];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Services')),

      // Main content scrollable
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Date & Time selection card ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Column(
                children: [
                  // Label
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Duration", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  // Date picker
                  Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        title: Text('Select Date'),
                        subtitle: Text(
                          '${controller.selectedDate.value.toLocal()}'.split(' ')[0],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () => controller.pickDate(context),
                      ),
                    ),
                  ),

                  // Time picker
                  Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        title: Text('Select Time'),
                        subtitle: Text(
                          controller.selectedTime.value.format(context),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.access_time),
                        onTap: () => controller.pickTime(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // --- Section Header ---
            Row(
              children: [
                Expanded(child: const Divider(indent: 8, endIndent: 8)),
                Text(
                  "Select Service Types",
                  style: TextStyle(color: AppColors.primary, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Expanded(child: const Divider(indent: 8, endIndent: 8)),
              ],
            ),

            // --- Service list per category ---
            Obx(() {
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: categories.map((category) {
                  // Filter services by category
                  var categoryServices = controller.services.where((s) => s.category == category).toList();

                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category header with bottom sheet trigger
                        GestureDetector(
                          onTap: () {
                            if (categoryServices.every((service) => service.isSelected.value)) {
                              showSnackBarRed('All services are already selected.');
                            } else {
                              Get.bottomSheet(SelectionBottomSheet(services: categoryServices));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(category, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Icon(Icons.keyboard_arrow_down_sharp),
                              ],
                            ),
                          ),
                        ),

                        // Selected services within the category
                        ...categoryServices.map((service) {
                          return Visibility(
                            visible: service.isSelected.value,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                title: Text(service.name),
                                subtitle: service.price != null
                                    ? Text(
                                        '\$${((service.price ?? 0) * service.count.value).toStringAsFixed(2)}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    : null,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 4,
                                  children: [
                                    GestureDetector(
                                      onTap: () => controller.decrementCount(service),
                                      child: Icon(Icons.remove_circle, color: AppColors.primary.withValues(alpha: 0.7)),
                                    ),
                                    RegularTextView(data: "${service.count}"),
                                    GestureDetector(
                                      onTap: () => controller.incrementCount(service),
                                      child: Icon(Icons.add_circle, color: AppColors.primary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),

      // --- Bottom Confirm Button ---
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CommonButton(
          onTap: () {
            if (controller.selectedServices.isNotEmpty) {
              Get.to(() => BookingConfirmationScreen());
            } else {
              showSnackBarRed('Please select at least one service');
            }
          },
          title: 'Confirm Booking',
        ),
      ),
    );
  }
}
