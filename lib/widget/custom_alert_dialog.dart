// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:pos_system/config/app_colors.dart';
//
//
// class CustomAlertDialog extends StatelessWidget {
//   static var GREEN = 0;
//   static var YELLOW = 1;
//
//   CustomAlertDialog(
//       {Key? key,
//       this.title = "Warning",
//       this.btPositive = "Yes",
//       this.btNegative = "Cancel",
//       this.type = 1,
//       this.isHideNegative = false,
//       required this.msg,
//       required this.onPositive})
//       : super(key: key);
//
//   static var RED = 2;
//
//   CustomAlertDialog.m(
//       {Key? key,
//       this.title = "Warning",
//       this.btPositive = "Yes",
//       this.btNegative = "Cancel",
//       this.type = 1,
//       this.isHideNegative = false,
//       required this.msg,
//       required this.onPositive,
//       required this.onNagative})
//       : super(key: key);
//
//   String title;
//   String btPositive;
//   String btNegative;
//   int type;
//   final bool isHideNegative;
//
//   final String msg;
//   VoidCallback onPositive;
//   VoidCallback onNagative = () {};
//   Color baseColor = AppColors.warning;
//
//   @override
//   Widget build(BuildContext context) {
//     if (type == 2) {
//       baseColor = Colors.red;
//     } else if (type == 3) {
//       baseColor = Colors.green;
//     }
//
//     return Dialog(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold, color: baseColor, fontSize: 18),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             Html(data: msg),
//             // Text(msg,
//             //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Visibility(
//                     visible: !isHideNegative,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         onNagative();
//                       },
//                       child: Text(
//                         btNegative,
//                         style: const TextStyle(color: Colors.black38),
//                       ),
//                     )),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     onPositive();
//                   },
//                   child: Text(btPositive, style: TextStyle(color: baseColor)),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
