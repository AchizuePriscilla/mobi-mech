import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobi_mech/shared/shared.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final Widget? suffix;
  final Widget? prefix;
  final Function(String)? validator;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final bool? centeredHint;
  final TextInputAction textInputAction;
  final Color? borderColor;
  final Color? hintColor;
  final Color? textColor;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? formatters;
  final bool obscureText;
  final bool expands;
  final double? height;
  final bool isBold;

  const CustomTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.suffix,
    this.prefix,
    this.height,
    this.validator,
    this.keyboardType,
    this.expands = false,
    this.hintStyle,
    this.formatters,
    this.textInputAction = TextInputAction.next,
    this.centeredHint = false,
    this.readOnly = false,
    this.obscureText = false,
    this.borderColor,
    this.hintColor,
    this.textColor,
    this.isBold = false,
    this.maxLines,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  String get _label => label ?? "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_label.isNotEmpty) ...{
          Text(
            _label,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400),
          ),
          const CustomSpacer(
            flex: 1,
          ),
        },
        SizedBox(
          height: height ?? 40.h,
          child: TextFormField(
            expands: expands,
            obscureText: obscureText,
            onTap: onTap,
            readOnly: readOnly,
            minLines: expands ? null : 1,
            maxLines: expands ? null : 1,
            inputFormatters: formatters,
            textCapitalization: textCapitalization,
            style: TextStyle(
                fontSize: 14.sp,
                color: textColor,
                fontWeight: isBold ? FontWeight.w600 : FontWeight.w400),
            textInputAction: textInputAction,
            autovalidateMode: AutovalidateMode.disabled,
            textAlign: centeredHint! ? TextAlign.center : TextAlign.start,
            keyboardType: keyboardType,
            controller: controller,
            focusNode: focusNode,
            validator: (value) {
              return validator?.call(value ?? "");
            },
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffix,
              prefixIcon: prefix,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              hintStyle: hintStyle ??
                  TextStyle(
                      fontSize: 14.sp,
                      color: hintColor ?? Palette.lightGrey,
                      fontWeight: isBold ? FontWeight.w600 : FontWeight.w400),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.lightGrey,
                ),
                borderRadius: BorderRadius.circular(30.w),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.lightGrey,
                ),
                borderRadius: BorderRadius.circular(30.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.lightGrey,
                ),
                borderRadius: BorderRadius.circular(30.w),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(30.w),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(30.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
