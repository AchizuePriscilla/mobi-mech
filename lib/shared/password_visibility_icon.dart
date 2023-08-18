import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobi_mech/shared/palette.dart';

class PasswordVisibilityIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final bool value;
  final Color? color;
  final double? size;

  const PasswordVisibilityIcon(
      {Key? key,
      required this.onPressed,
      this.value = false,
      this.color,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: color ?? Palette.grey,
          size: size ?? 20.w,
        ),
      ),
    );
  }
}
