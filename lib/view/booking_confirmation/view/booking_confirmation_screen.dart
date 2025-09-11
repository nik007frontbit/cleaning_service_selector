import 'package:cleaning_service_selector/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/app_button.dart';
import '../../service_selection/controller/service_controller.dart';
import '../widget/info_tile.dart';
import '../widget/success_order_bottom_sheet.dart';

class BookingConfirmationScreen extends StatelessWidget {
  BookingConfirmationScreen({super.key});

  /// GetX controller to access selected services, total price/duration, and date/time
  final ServiceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmation')),

      // Main content scrollable
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Service Booked",
                  style: TextStyle(color: AppColors.blackColor, fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10),

              // List of selected services
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: controller.selectedServices.map((service) {
                  final subtotal = (service.price ?? 0) * service.count.value;
                  return ListTile(
                    title: Text('${service.name} x${service.count.value}'),
                    subtitle: Text('Duration: ${service.count.value * (service.duration ?? 30)} min'),
                    trailing: Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14)),
                  );
                }).toList(),
              ),

              const Divider(),

              // Total duration, date, and time using reusable InfoTile
              InfoTile(title: 'Total Duration:', value: '${controller.totalDuration} minutes'),
              InfoTile(title: 'Date:', value: '${controller.selectedDate.value.toLocal()}'.split(' ')[0]),
              InfoTile(title: 'Time:', value: controller.selectedTime.value.format(context)),

              const Divider(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Bottom navigation button shows total cost and triggers success bottom sheet
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CommonButton(
          onTap: () {
            // Show a success bottom sheet on booking confirmation
            Get.bottomSheet(SuccessOrderBottomSheet());
          },
          title: 'Total Cost: \$${controller.totalPrice.toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
