import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CommonPhoneField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final String? validationMessage;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<PhoneNumber>? onChanged;
  final Function(String)? onCountryChanged;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final Color? bgColor;
  final Color? borderColor;
  final double? borderRadius;
  final String? initialCountryCode;
  final bool showDropdownIcon;
  final bool autofocus;
  final bool readOnly;
  final String languageCode;

  const CommonPhoneField({
    Key? key,
    this.title,
    this.hintText,
    this.validationMessage,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onCountryChanged,
    this.margin,
    this.contentPadding,
    this.bgColor,
    this.borderColor,
    this.borderRadius,
    this.initialCountryCode = "IN",
    this.showDropdownIcon = false,
    this.autofocus = false,
    this.readOnly = false,
    this.languageCode = "en",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: AppTextStyle.regular400.copyWith(
              fontSize: 16,
              color: AppColors.fontPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          margin: margin,
          child: IntlPhoneField(
            controller: controller,
            focusNode: focusNode,
            readOnly: readOnly,
            autofocus: autofocus,
            initialCountryCode: initialCountryCode,
            showDropdownIcon: showDropdownIcon,
            languageCode: languageCode,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.number.trim().isEmpty) {
                return validationMessage ?? "Phone number is required!";
              }
              return null;
            },
            onChanged: onChanged,
            onCountryChanged: (country) {
              if (onCountryChanged != null) {
                onCountryChanged!(country.dialCode);
              }
            },
            decoration: InputDecoration(
              hintText: hintText ?? "Enter your number",
              filled: true,
              fillColor: bgColor ?? AppColors.whiteColor,
              contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.borderColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.borderColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? AppColors.borderColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.redColor),
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String? validateMobileNumber(PhoneNumber? value) {
  if (value == null || value.number.trim().isEmpty) {
    return "Phone number is required!";
  }

  try {
    if (!value.isValidNumber()) {
      return "Phone number is invalid";
    }
  } on NumberTooShortException {
    return "Phone number is too short";
  } on NumberTooLongException {
    return "Phone number is too long";
  } on InvalidCharactersException {
    return "Phone number contains invalid characters";
  } catch (_) {
    return "Invalid mobile number";
  }

  return null; // ✅ Valid
}
