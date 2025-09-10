
import 'package:flutter/material.dart';

import '../config/app_constants.dart';
import '../config/app_text_style.dart';

class LightTextView extends StatelessWidget {
  const LightTextView(
      {super.key,
      required this.data,
      this.rightPadding = 0,
      this.leftPadding = 0,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.fontWeight,
      this.textColor,
      this.fontSize,
      this.textAlign,
      this.textDecoration,
      this.maxLine,
      this.fontStyle,
      this.textOverflow,
      this.lineHeight});

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLine;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: rightPadding, left: leftPadding, top: topPadding, bottom: bottomPadding),
      child: Text(data,
          style: AppTextStyle.regularTextStyle.copyWith(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              decoration: textDecoration,
              decorationColor: textColor,
              height: lineHeight,
              decorationThickness: AppConstants.lineStrikethrough),
          textAlign: textAlign,
          maxLines: maxLine,
          overflow: textOverflow),
    );
  }
}

class RegularTextView extends StatelessWidget {
  const RegularTextView(
      {super.key,
      required this.data,
      this.rightPadding = 0,
      this.leftPadding = 0,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.fontWeight,
      this.textColor,
      this.fontSize,
      this.textAlign,
      this.textDecoration,
      this.maxLine,
      this.fontStyle,
      this.textOverflow,
      this.lineHeight});

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLine;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: rightPadding, left: leftPadding, top: topPadding, bottom: bottomPadding),
      child: Text(data,
          style: AppTextStyle.regularTextStyle.copyWith(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              decoration: textDecoration,
              decorationColor: textColor,
              height: lineHeight,
              decorationThickness: AppConstants.lineStrikethrough),
          textAlign: textAlign,
          maxLines: maxLine,
          overflow: textOverflow),
    );
  }
}

class MediumTextView extends StatelessWidget {
  const MediumTextView(
      {super.key,
      required this.data,
      this.rightPadding = 0,
      this.leftPadding = 0,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.fontWeight,
      this.textColor,
      this.fontSize,
      this.textAlign,
      this.textDecoration,
      this.maxLine,
      this.fontStyle,
      this.textOverflow,
      this.lineHeight});

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLine;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: rightPadding, left: leftPadding, top: topPadding, bottom: bottomPadding),
      child: Text(data,
          style: AppTextStyle.mediumTextStyle.copyWith(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              decoration: textDecoration,
              decorationColor: textColor,
              height: lineHeight,
              decorationThickness: AppConstants.lineStrikethrough),
          textAlign: textAlign,
          maxLines: maxLine,
          overflow: textOverflow),
    );
  }
}

class SemiBoldTextView extends StatelessWidget {
  const SemiBoldTextView(
      {super.key,
      required this.data,
      this.rightPadding = 0,
      this.leftPadding = 0,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.fontWeight,
      this.textColor,
      this.fontSize,
      this.textAlign,
      this.textDecoration,
      this.maxLine,
      this.fontStyle,
      this.textOverflow,
      this.lineHeight});

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLine;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: rightPadding, left: leftPadding, top: topPadding, bottom: bottomPadding),
      child: Text(data,
          style: AppTextStyle.semiBoldTestStyle.copyWith(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              decoration: textDecoration,
              decorationColor: textColor,
              height: lineHeight,
              decorationThickness: AppConstants.lineStrikethrough),
          textAlign: textAlign,
          overflow: textOverflow,
          maxLines: maxLine),
    );
  }
}

class BoldTextView extends StatelessWidget {
  const BoldTextView(
      {super.key,
      required this.data,
      this.rightPadding = 0,
      this.leftPadding = 0,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.fontWeight,
      this.textColor,
      this.fontSize,
      this.textAlign,
      this.textDecoration,
      this.maxLine,
      this.fontStyle,
      this.textOverflow,
      this.lineHeight});

  final String data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLine;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final double? lineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: rightPadding, left: leftPadding, top: topPadding, bottom: bottomPadding),
      child: Text(data,
          style: AppTextStyle.boldTextStyle.copyWith(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontStyle: fontStyle,
              decoration: textDecoration,
              decorationColor: textColor,
              height: lineHeight,
              decorationThickness: AppConstants.lineStrikethrough),
          overflow: textOverflow,
          textAlign: textAlign,
          maxLines: maxLine),
    );
  }
}
