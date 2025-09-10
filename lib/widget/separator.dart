import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double thickness;
  final double vPadding;
  final double hPadding;
  final Color? mColor;

  const Separator(
      {Key? key,
      this.thickness = 0,
      this.hPadding = 0,
      this.vPadding = 0,
      this.mColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      child: Divider(
        thickness: thickness,
        height: 1,
        color: mColor ?? Colors.grey[400],
      ),
    );
  }
}
