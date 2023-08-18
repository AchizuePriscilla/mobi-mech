import 'package:flutter/material.dart';
import 'package:mobi_mech/shared/shared.dart';

class Button extends StatelessWidget {
  final String text;
  final bool loading;
  final Function onPressed;
  final bool outlined;
  final bool halfSized;
  final bool active;
  final bool hasIcon;
  final Size? size;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;

  const Button(
      {Key? key,
      required this.text,
      this.loading = false,
      required this.onPressed,
      this.outlined = false,
      this.halfSized = false,
      this.active = true,
      this.hasIcon = false,
      this.size,
      this.color,
      this.borderColor,
      this.textColor})
      : super(key: key);

  MaterialStateProperty<Size> get minSize => MaterialStateProperty.resolveWith(
        (states) =>
            size ??
            Size(
              300.w,
              40.h,
            ),
      );
  MaterialStateProperty<Size> get dialogMinSize =>
      MaterialStateProperty.resolveWith(
        (states) => Size(
          150.w,
          40.h,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget child = loading
        ? SizedBox(
            height: 30.h,
            width: 30.h,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Palette.white),
            ),
          )
        : Text(
            text,
            style: TextStyle(
                fontSize: halfSized ? 14.sp : 14.sp,
                fontWeight: FontWeight.w400,
                color: textColor ?? Palette.black),
          );
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        fixedSize: MaterialStateProperty.resolveWith((states) => size),
        minimumSize: halfSized ? dialogMinSize : minSize,
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => !active ? null : Palette.white.withOpacity(.75),
        ),
        backgroundColor: outlined
            ? null
            : MaterialStateProperty.resolveWith(
                (states) => color ?? (!active ? null : Palette.white),
              ),
        side: outlined
            ? MaterialStateProperty.resolveWith(
                (states) => BorderSide(
                  color: borderColor ?? Palette.lightGrey,
                ),
              )
            : null,
      ),
      child: hasIcon
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  child,
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Palette.white,
                    size: 22,
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
              ],
            ),
      onPressed: () => active ? onPressed() : () {},
    );
  }
}
