import 'package:flutter/material.dart';

// BottomSheet round shape
RoundedRectangleBorder roundRectangleShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  );
}
