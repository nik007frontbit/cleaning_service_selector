import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_service_selector/utils/other.dart';


import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_images.dart';

class CommonNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final String? itemName;
  final int? index;
  final int? length;
  final bool? isPlaceholderBorder;
  final String imagePlaceholder;
  final double? height;
  final double? placeTextSize;
  final double? width;
  final double radius;

  const CommonNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.itemName,
    this.isPlaceholderBorder,
    this.index = 0,
    this.length = 0,
    this.placeTextSize = 16,
    this.radius = 0,
    this.imagePlaceholder = AppImages.placeholderSq,
  });

  @override
  Widget build(BuildContext context) {
    int safeIndex = (index ?? 0) % AppColors.randomColorArr.length;
    final hasImageUrl = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: hasImageUrl
          ? CachedNetworkImage(
              imageUrl: imageUrl ?? "",
              height: height,
              width: width,
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                imagePlaceholder,
                height: height,
                width: width,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => _fallbackImage(context, safeIndex),
            )
          : _fallbackImage(context, safeIndex),
    );
  }

  Widget _fallbackImage(BuildContext context, int safeIndex) {
    return !itemName.isNullOrEmpty()
        ? Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: AppColors.randomColorArr[safeIndex].withOpacity(0.15),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: (isPlaceholderBorder??true)?AppColors.borderColor:AppColors.transparentColor),
            ),
            alignment: Alignment.center,
            child: Text(
              (itemName?.substring(0, 1) ?? "-").toUpperCase(),
              style: TextStyle(
                fontSize: placeTextSize ?? 16,
                color: AppColors.randomColorArr[safeIndex],
              ),
            ),
          )
        : Image.asset(
            imagePlaceholder,
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
  }
}
