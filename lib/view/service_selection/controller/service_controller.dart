import 'package:cleaning_service_selector/widget/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/service_model.dart' show Service;

class ServiceController extends GetxController {
  RxList<Service> services = <Service>[
    /// List of all services with their details (name, category, price, duration)
    // Standard Cleaning
    Service(name: 'Bedroom', category: 'Standard', price: 17.25, duration: 30),
    Service(name: 'Bathroom', category: 'Standard', price: 21.00, duration: 40),
    Service(name: 'Half Bathroom', category: 'Standard', price: 10.50, duration: 20),
    Service(name: 'Other Room', category: 'Standard', price: 26.00, duration: 45),

    // Deep Cleaning
    Service(name: 'Bedroom', category: 'Deep Cleaning', price: 23.50, duration: 45),
    Service(name: 'Bathroom', category: 'Deep Cleaning', price: 38.50, duration: 60),
    Service(name: 'Half Bathroom', category: 'Deep Cleaning', price: 17.00, duration: 30),
    Service(name: 'Other Room', category: 'Deep Cleaning', price: 38.50, duration: 60),

    // Add-Ons
    Service(name: 'Refrigerator (inside)', category: 'Add-Ons', price: 17.00, duration: 30),
    Service(name: 'Microwave (inside)', category: 'Add-Ons', price: 4.25, duration: 15),
    Service(name: 'Oven (inside)', category: 'Add-Ons', price: 19.25, duration: 35),
    Service(name: 'Stovetop (scrub)', category: 'Add-Ons', price: 8.50, duration: 20),
    Service(name: 'Dishwasher (inside)', category: 'Add-Ons', price: 6.50, duration: 15),
    Service(name: 'Toaster (crumbs)', category: 'Add-Ons', price: 2.25, duration: 10),
    Service(name: 'Coffee Maker (descale)', category: 'Add-Ons', price: 2.25, duration: 10),
    Service(name: 'Blender (inside)', category: 'Add-Ons', price: 2.25, duration: 10),
    Service(name: 'Washer (inside)', category: 'Add-Ons', price: 6.50, duration: 20),
    Service(name: 'Dryer (inside)', category: 'Add-Ons', price: 6.50, duration: 20),
    Service(name: 'Air Fryer (inside)', category: 'Add-Ons', price: 4.25, duration: 15),
    Service(name: 'Electric Kettle (descale)', category: 'Add-Ons', price: 2.25, duration: 10),
    Service(name: 'Dishes (wash)', category: 'Add-Ons', price: 8.50, duration: 25),
  ].obs;

  /// Date and Time Selection
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  /// Opens a date picker to select a booking date
  void pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (date != null) {
      selectedDate.value = date;
    }
  }

  /// Opens a time picker to select a booking time
  /// Validates that the selected time is not before the current time if date is today
  void pickTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(context: context, initialTime: selectedTime.value);

    if (time != null) {
      final now = TimeOfDay.now();
      bool isToday =
          selectedDate.value.year == DateTime.now().year &&
          selectedDate.value.month == DateTime.now().month &&
          selectedDate.value.day == DateTime.now().day;
      if (isToday && (time.hour < now.hour || (time.hour == now.hour && time.minute < now.minute))) {
        showSnackBarRed('Please select a time after the current time');
        return;
      }
      selectedTime.value = time;
    }
  }

  /// Toggles selection of a service
  /// If unselected, resets count to 0
  /// If selected and count is 0, sets count to 1
  void selectService(Service service) {
    service.isSelected.value = !(service.isSelected.value);
    if (!service.isSelected.value) {
      service.count.value = 0;
    } else {
      service.count.value = service.count.value == 0 ? 1 : service.count.value;
    }
    services.refresh();
  }

  /// Increments the count of a selected service
  void incrementCount(Service service) {
    service.count.value++;
    services.refresh();
  }

  /// Decrements the count of a selected service
  /// If count reaches 0, marks the service as unselected
  void decrementCount(Service service) {
    if (service.count.value > 0) {
      service.count.value--;
      if (service.count.value == 0) {
        service.isSelected.value = false;
        service.count.value = 0;
      }
      services.refresh();
    } else {
      service.isSelected.value = false;

      service.count.value = 0;
    }
  }

  /// Reset all selected services, counts, and optionally date/time
  void resetSelections({bool resetDateTime = false}) {
    for (var service in services) {
      service.isSelected.value = false;
      service.count.value = 0;
    }

    services.refresh();

    if (resetDateTime) {
      selectedDate.value = DateTime.now();
      selectedTime.value = TimeOfDay.now();
    }
  }

  /// Returns the list of services that are currently selected
  List<Service> get selectedServices => services.where((service) => service.isSelected.value).toList();

  /// Calculates the total price of all selected services
  double get totalPrice => selectedServices.fold(0, (sum, service) => sum + (service.price ?? 0));

  /// Calculates the total duration of all selected services in minutes
  int get totalDuration {
    return selectedServices.fold(0, (sum, service) => sum + (service.count.value * (service.duration ?? 30)));
  }
}
