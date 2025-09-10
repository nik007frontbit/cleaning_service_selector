import 'dart:io';

import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import '../config/app_colors.dart';
import 'catched_network_image.dart';

class CommonAvatarPicker extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final VoidCallback onTap;
  final double radius;
  final bool showEditIcon;

  const CommonAvatarPicker({
    super.key,
    required this.onTap,
    this.imageFile,
    this.imageUrl,
    this.radius = 60,
    this.showEditIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final double size = radius * 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size ,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.borderGreyColor)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey[300],
              backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
              child: imageFile == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: CommonNetworkImage(
                        imageUrl: imageUrl,
                        height: size,
                        width: size,
                        radius: radius,
                      ),
                    )
                  : null,
            ),
            if (showEditIcon)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(RemixIcons.pencil_line,  color: AppColors.primary,),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
