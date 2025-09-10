import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_text_style.dart';

class CommonDropDown extends StatelessWidget {
  final String? title;
  final List<String>? itemList;
  final String? dropDownValue;
  final String? validationMessage;
  final String? hintText;
  final double? topPadding;
  final double? bottomPadding;
  final Color? fillColor;
  final double? borderRadius;
  final bool isTransparentColor;
  final bool needValidation;
  final Color? borderColor;
  final bool absorbing;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;

  final void Function(String?)? onChange;

  const CommonDropDown(
      {Key? key,
      this.title,
      this.itemList,
      this.contentPadding,
      this.margin,
      this.absorbing = false,
      this.bottomPadding,
      this.borderColor,
      this.borderRadius,
      this.dropDownValue,
      this.onChange,
      this.validator,
      this.validationMessage,
      this.topPadding,
      this.hintText,
      this.fillColor,
      this.isTransparentColor = false,
      this.needValidation = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: topPadding ?? 0),
          if (title != null)
            Text(
              title!,
              style: AppTextStyle.regular400.copyWith(fontSize: 17),
            ),
          if (title != null) const SizedBox(height: 6),
          Container(
            margin: margin,
            child: DropdownButtonFormField(
              style: AppTextStyle.regular400.copyWith(fontSize: 16),
              decoration: InputDecoration(
                filled: true,
                fillColor: fillColor ?? AppColors.whiteColor,
                hintText: hintText,
                hintStyle: AppTextStyle.regular400.copyWith(
                    color: borderColor ?? AppColors.blackColor, fontSize: 15),
                contentPadding: contentPadding ??
                    const EdgeInsets.only(
                        top: 8, bottom: 16, right: 20, left: 20),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isTransparentColor
                            ? AppColors.transparentColor
                            : (borderColor ?? AppColors.borderColor)),
                    borderRadius: BorderRadius.circular(borderRadius ?? 10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isTransparentColor
                            ? AppColors.transparentColor
                            : (borderColor ?? AppColors.borderColor)),
                    borderRadius: BorderRadius.circular(borderRadius ?? 10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isTransparentColor
                            ? AppColors.transparentColor
                            : (borderColor ?? AppColors.borderColor)),
                    borderRadius: BorderRadius.circular(borderRadius ?? 10)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isTransparentColor
                            ? AppColors.transparentColor
                            : (borderColor ?? AppColors.borderColor)),
                    borderRadius: BorderRadius.circular(borderRadius ?? 10)),
              ),
              validator: needValidation == true
                  ? (v) {
                      if (v == null) {
                        return "$validationMessage is required";
                      }
                      return null;
                    }
                  : null,
              isDense: true,
              // focusNode: FocusNode(),

              onChanged: onChange,
              value: dropDownValue,
              items: itemList!.map((selectedType) {
                return DropdownMenuItem(
                  value: selectedType,
                  child: Text(
                    selectedType,
                    style: const TextStyle(fontSize: 15, fontFamily: "Poppins"),
                  ),
                );
              }).toList(),
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.blackColor,
              ),
            ),
          ),
          SizedBox(height: bottomPadding ?? 16),
        ],
      ),
    );
  }
}
