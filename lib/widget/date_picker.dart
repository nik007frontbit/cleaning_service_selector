// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// Future<String?> selectDate(BuildContext context,
//     {DateTime? selectDate,
//     DateTime? firstDate,
//     DateTime? lastDate,
//     String? dateFormat
//
//     }) async {
//   final DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: selectDate ?? DateTime.now(),
//     firstDate: firstDate ?? DateTime(1900),
//     lastDate: lastDate ?? DateTime(2100),
//
//   );
//   if (picked != null) {
//     debugPrint('date  $picked');
//     return DateFormat(dateFormat ?? "dd/MM/yyyy").format(picked);
//   } else {
//     return null;
//   }
// }
