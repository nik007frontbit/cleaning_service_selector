import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CommonButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onTap;
  final bool isExpand;
  final double? buttonWidth;
  final double? borderWidth;
  final double? borderRadius;
  final double? textSize;
  final Color? backColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? height;
  final double? frontImageHeight;
  final bool isFront;
  final bool isShadow;
  final Widget? iconWidget;
  final EdgeInsets? buttonPadding;
  final EdgeInsetsGeometry? margin;
  final String? frontImage;
  final Color? frontImageColor;

  const CommonButton({
    Key? key,
    this.title,
    this.icon,
    this.onTap,
    this.isExpand = false,
    this.buttonWidth,
    this.borderWidth,
    this.borderRadius,
    this.textSize,
    this.backColor,
    this.textColor,
    this.textStyle,
    this.borderColor,
    this.height,
    this.frontImageHeight,
    this.isFront = false,
    this.isShadow = false,
    this.iconWidget,
    this.buttonPadding,
    this.margin,
    this.frontImage,
    this.frontImageColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        width: buttonWidth,
        padding: buttonPadding ??
            const EdgeInsets.only(top: 14, bottom: 14, right: 16, left: 16),
        decoration: BoxDecoration(
          color: backColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          boxShadow: <BoxShadow>[
            if (isShadow)
              BoxShadow(
                color: AppColors.primary,
                blurRadius: 15.0,
                spreadRadius: -4,
                offset: const Offset(0.0, 6),
              )
          ],
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth ?? 1)
              : null,
        ),
        child: Row(
          mainAxisSize: isExpand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && isFront)
              Image.asset(
                frontImage!,
                color: frontImageColor,
                height: frontImageHeight,
              ),
            if (icon != null && isFront) const SizedBox(width: 8),
            if (icon != null && !isFront) const SizedBox(width: 8),
            iconWidget ??
                (icon != null && !isFront
                    ? Icon(
                  icon,
                  color: textColor ?? AppColors.whiteColor,
                  size: 16,
                )
                    : const SizedBox()),
            Flexible(
              child: Text(
                "$title",
                style: textStyle ??
                    AppTextStyle.regular600.copyWith(
                      fontSize: textSize ?? 18,
                      color: textColor ?? AppColors.whiteColor,
                      letterSpacing: 0.75,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
