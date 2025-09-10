import 'package:get/get.dart';

/// Model representing a cleaning service
class Service {
  /// Name of the service (e.g., "Bedroom", "Microwave (inside)")
  String name;

  /// Category of the service (e.g., "Standard", "Deep Cleaning", "Add-Ons")
  String category;

  /// Price of the service (nullable in case price is not set)
  double? price;

  /// Duration of the service in minutes (nullable in case not set)
  int? duration;

  /// Reactive boolean to track if the service is selected by the user
  RxBool isSelected;

  /// Reactive integer to track how many units of this service are selected
  RxInt count = 0.obs;

  /// Constructor
  Service({
    required this.name,
    required this.category,
    this.price,
    this.duration,
    bool isSelected = false,
    int count = 0,
  }) : isSelected = isSelected.obs; // Wrap initial selection in RxBool
}
