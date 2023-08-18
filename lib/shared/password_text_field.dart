import 'package:flutter/material.dart';
import 'package:mobi_mech/shared/shared.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  const PasswordTextField({super.key, this.controller, required this.hint});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _hidePassword = true;

  void toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      obscureText: _hidePassword,
      hint: widget.hint,
      controller: widget.controller,
      suffix: PasswordVisibilityIcon(
        onPressed: toggleVisibility,
        value: _hidePassword,
      ),
    );
  }
}
