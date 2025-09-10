import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';
import '../utils/validation/validator.dart';

class CommonTextField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? validationMessage;
  // final String? suffixText;
  final bool needValidation;
  final bool isEmailValidation;
  final double? topPadding;
  final double? bottomPadding;
  final TextEditingController? controller;
  final bool isPhoneValidation;
  final bool isPasswordValidation;
  final TextInputType? textInputType;
  final int? maxLine;
  final int? maxLength;
  final double? borderRadius;
  final Widget? suffixIcon;
  final Color? borderColor;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  // final TextStyle? suffixStyle;
  final Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool isTransparentColorBorder;
  final bool isBigTitle;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChange;
  final bool obscureText;
  final Color? titleColor;
  final bool readOnly;
  final Color? bgColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? titleMargin;

  const CommonTextField({
    Key? key,
    this.title,
    this.needValidation = false,
    this.isEmailValidation = false,
    this.hintText,
    this.validationMessage,
    this.topPadding,
    this.borderColor,
    this.bottomPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    // this.suffixText,
    // this.suffixStyle,
    this.contentPadding,
    this.isPhoneValidation = false,
    this.textInputType,
    this.textAlign,
    this.borderRadius,
    this.inputFormatters,
    this.maxLine,
    this.maxLength,
    this.bgColor,
    this.isTransparentColorBorder = false,
    this.onTap,
    this.suffixIcon,
    this.isBigTitle = false,
    this.prefixIcon,
    this.validator,
    this.titleColor,
    this.isPasswordValidation = false,
    this.obscureText = false,
    this.onChange,
    this.margin,
    this.titleMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPadding ?? 0),
        if (title != null)
          Container(
            margin: titleMargin,
            child: Text(
              '$title',
              style: isBigTitle
                  ? AppTextStyle.regular600
                      .copyWith(fontSize: 17, color: titleColor)
                  : AppTextStyle.regular400
                      .copyWith(fontSize: 16, color: titleColor  ?? AppColors.textColor),
            ),
          ),
        if (title != null) const SizedBox(height: 8),
        Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            // boxShadow: [
            //   BoxShadow(
            //     offset: Offset(0, 0),
            //     blurRadius: 1,
            //     spreadRadius: 1,
            //     color: Colors.black.withOpacity(0.08),
            //   ),
            // ],
          ),
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: maxLine,
            textInputAction: TextInputAction.done,
            textAlign: textAlign ?? TextAlign.start,
            onTap: onTap,
            maxLength: maxLength,
            controller: controller,
            onChanged: onChange,
            obscureText: obscureText,
            readOnly: readOnly,
            inputFormatters: inputFormatters ?? [],
            focusNode: focusNode,
            autofocus: autofocus,
            keyboardType: textInputType ?? TextInputType.text,
            style: AppTextStyle.regular500.copyWith(fontSize: 15),
            decoration: InputDecoration(
              fillColor: bgColor ?? AppColors.whiteColor,
              contentPadding: contentPadding ??
                  const EdgeInsets.only(
                      top: 8, bottom: 16, right: 20, left: 20),
              isDense: true,
              filled: true,
              counterText: "",
              hintText: hintText ?? "",

              suffixIcon: suffixIcon,
              // suffixText: suffixText,
              // suffixStyle: suffixStyle,
              prefixIcon: prefixIcon,
              hintStyle: AppTextStyle.regular400.copyWith(
                  color: borderColor ?? AppColors.blackColor, fontSize: 13),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isTransparentColorBorder
                          ? AppColors.transparentColor
                          : (borderColor ?? AppColors.borderGreyColor)),
                  borderRadius: BorderRadius.circular(borderRadius ?? 10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isTransparentColorBorder
                          ? AppColors.transparentColor
                          : (borderColor ?? AppColors.borderGreyColor)),
                  borderRadius: BorderRadius.circular(borderRadius ?? 10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isTransparentColorBorder
                          ? AppColors.transparentColor
                          : (borderColor ?? AppColors.borderGreyColor)),
                  borderRadius: BorderRadius.circular(borderRadius ?? 10)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: isTransparentColorBorder
                          ? AppColors.transparentColor
                          : (borderColor ?? AppColors.borderGreyColor)),
                  borderRadius: BorderRadius.circular(borderRadius ?? 10)),
            ),
            validator: needValidation
                ? validator ??
                    (v) {
                      return TextFieldValidation.validation(
                          message: validationMessage ?? title,
                          value: v,
                          isPasswordValidator: isPasswordValidation,
                          isPhone: isPhoneValidation,
                          isEmailValidator: isEmailValidation);
                    }
                : null,
          ),
        ),
        SizedBox(height: bottomPadding ?? 16),
      ],
    );
  }
}
