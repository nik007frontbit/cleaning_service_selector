import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class CommonBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? margin;

  const CommonBackButton({
    super.key,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap ?? () => Get.back(),
      child: Container(
        margin: margin ?? const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.backContainer,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.arrow_back,
          color: iconColor ?? AppColors.blackColor,
        ),
      ),
    );
  }
}
