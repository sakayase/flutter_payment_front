import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final String? Function(String?)? validatorFunction;
  final String? hint;
  final String? label;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? formatter;
  final TextInputType? keyboard;
  const Input({
    Key? key,
    required this.validatorFunction,
    this.hint,
    this.label,
    this.labelStyle,
    this.formatter,
    this.keyboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatter,
      keyboardType: keyboard,
      validator: (value) {
        return validatorFunction!(value);
      },
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        labelStyle: labelStyle,
      ),
    );
  }
}
