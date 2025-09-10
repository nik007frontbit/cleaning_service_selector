import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


bool isDigitsOnly(String? s) {
  if (s == null) {
    return false;
  }
  s = s.replaceAll(' ', '');
  return int.tryParse(s) != null;
}

bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

String formatFullName(String? firstName, String? lastName) {
  // Trim each name to avoid extra spaces
  String trimmedFirstName = firstName?.trim() ?? '';
  String trimmedLastName = lastName?.trim() ?? '';

  // Combine the names with a space if both are present
  if (!trimmedFirstName.isNullOrEmpty() && !trimmedLastName.isNullOrEmpty()) {
    return '$trimmedFirstName $trimmedLastName';
  }

  // Return the non-empty name if only one is available
  if (!trimmedFirstName.isNullOrEmpty()) {
    return trimmedFirstName;
  }
  if (!trimmedLastName.isNullOrEmpty()) {
    return trimmedLastName;
  }

  // Fallback if both are null or empty
  return '';
}


String formatManufacturerName(String manufacturerName, {int maxLength = 5}) {
  if (!manufacturerName.isNullOrEmpty() && (manufacturerName.length ?? 0) > maxLength) {
    return (manufacturerName).substring(0, maxLength).toUpperCase();
  } else {
    return manufacturerName.dashIfNullOrEmpty().toUpperCase();
  }
}

int stripWiseShowQtyFromSettings(String? sellingUnit, int? qty, int? size) {
  if (sellingUnit == "strip") {
    // qty always coming as loose from api
    if (qty == 0) {
      return qty ?? 0;
    } else {
      try {
        return qty! ~/ size!;
      } catch (e) {
        return 0;
      } // cast to int
    }
  } else {
    return qty ?? 0;
  }
}


int allTimeStripWiseQty(int? qty, int? size) {
  if (qty == 0) {
    return qty ?? 0;
  } else {
    return qty! ~/ size!;
  }
}

// to open external url
Future<void> exploreUrl(Uri url) async {
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw ("Oops! We can't open this page.");
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

// signup screen
bool containWords(String inputString, List<String> wordList) {
  bool found = false;

  for (String word in wordList) {
    if (inputString.toLowerCase().contains(word.toLowerCase())) {
      found = true;
      break;
    }
  }
  return found;
}

// capitalize first letter
extension StringExtension on String? {
  String capitalize() {
    if (this == null) {
      return "";
    }
    return "${this?[0].toUpperCase()}${this?.substring(1)}";
  }

  String removeUnderscoresAndCapitalize() {
    if (this == null) {
      return "";
    }

    // Split the input string by underscores
    List<String>? words = this?.split('_');

    // Capitalize the first letter of each word
    for (int index = 0; index < (words ?? []).length; index++) {
      if ((words ?? [])[index].isNotEmpty) {
        (words ?? [])[index] = (words ?? [])[index][0].toUpperCase() + (words ?? [])[index].substring(1).toLowerCase();
      }
    }

    // Join the words back into a single string
    return (words ?? []).join(' ');
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  String dashIfNullOrEmpty() {
    if (this == null || this!.isEmpty || this == "") {
      return "-";
    }
    return "$this";
  }

  String removeSpaceWithUnderScore() {
    if (this == null || this!.isEmpty) {
      return "";
    }

    return this!.replaceAll(" ", "_");
  }
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

bool isValidPercentage(String text) {
  final number = double.tryParse(text);
  return number != null && number >= 0 && number <= 100;
}

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

double calculatePercentageAmount(double value, double discountPercentage) {
  if (value == 0.0 || discountPercentage == 0.0) {
    return 0.0;
  }

  var discount_amount = ((value * discountPercentage) / 100);
  return discount_amount;
}

double getFileSizeInMB(int sizeInBytes, {int decimals = 2}) {
  // Convert bytes to megabytes
  double sizeInMB = sizeInBytes / (1024 * 1024);

  // Round to the specified number of decimal places
  return double.parse(sizeInMB.toStringAsFixed(decimals));
}
