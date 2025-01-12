import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymtrack/ui/core/widgets/input.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    super.key,
    this.keyboardType,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.icon,
    this.errorText,
    this.validator,
    this.onSaved,
    this.controller,
    this.initialValue,
    this.label,
  });

  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final Icon? icon;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[label!],
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          keyboardType: keyboardType,
          obscureText: false,
          onChanged: onChanged,
          decoration: defaultDecoration(
            context,
            hintText,
            labelText,
            icon,
            errorText,
          ),
          validator: validator,
          onSaved: onSaved,
          maxLines: 1,
          maxLength: 255,
          maxLengthEnforcement: MaxLengthEnforcement.none,
        ),
      ],
    );
  }
}
