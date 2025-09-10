import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter({
    this.maxValue,
    this.decimalRange = 2,
    this.digitsBeforeDecimal = 6,
  }) : assert(decimalRange >= 0);

  final double? maxValue;
  final int decimalRange;
  final int digitsBeforeDecimal;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String value = newValue.text;

    // Allow starting with "."
    if (value == ".") {
      return TextEditingValue(
        text: "0.",
        selection: TextSelection.collapsed(offset: 2),
      );
    }

    // Allow single leading zero before decimal (0.1)
    if (value.startsWith("0") && !value.startsWith("0.")) {
      value = value.replaceFirst(RegExp(r'^0+'), '');
      if (value.isEmpty) value = "0";
    }

    // Prevent multiple dots
    if ('.'.allMatches(value).length > 1) {
      return oldValue;
    }

    // Check digits before and after decimal
    if (value.contains(".")) {
      final parts = value.split(".");
      final beforeDecimal = parts[0];
      final afterDecimal = parts[1];

      if (beforeDecimal.length > digitsBeforeDecimal) return oldValue;
      if (afterDecimal.length > decimalRange) return oldValue;
    } else {
      // No decimal yet, limit digits before decimal
      if (value.length > digitsBeforeDecimal) return oldValue;
    }

    // Clamp by maxValue only if value can be parsed
    double? number = double.tryParse(value);
    if (number != null && maxValue != null && number > maxValue!) {
      value = maxValue!.toStringAsFixed(decimalRange);
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }
}
