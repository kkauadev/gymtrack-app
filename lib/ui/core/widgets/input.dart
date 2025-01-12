import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymtrack/ui/core/themes/colors.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.keyboardType,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.icon,
    this.errorText,
    this.validator,
    this.label,
  });

  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final Icon? icon;
  final String? errorText;
  final String? Function(String?)? validator;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[label!],
        TextFormField(
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
          maxLines: 1,
          maxLength: 255,
          maxLengthEnforcement: MaxLengthEnforcement.none,
        ),
      ],
    );
  }
}

InputDecoration defaultDecoration(
  BuildContext context,
  String? hintText,
  String? labelText,
  Icon? icon,
  String? errorText,
) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    prefixIcon: icon,
    errorText: errorText,
    counterText: "",
    filled: true,
    fillColor: Theme.of(context).colorScheme.inputPrimaryColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.inputSecondaryColor,
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
  );
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.showPassword,
    this.onPressShowPassword,
    this.validator,
  });

  final String? labelText;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onPressShowPassword;
  final bool? showPassword;
  final String? Function(String?)? validator;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: defineObscureText(widget.showPassword, _isObscured),
      maxLength: 255,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        counterText: "",
        filled: true,
        fillColor: colorScheme.inputPrimaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: colorScheme.inputPrimaryColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        suffixIcon: IconButton(
          icon: Icon(defineIcon(widget.showPassword, _isObscured)),
          onPressed: () {
            if (widget.onPressShowPassword != null) {
              widget.onPressShowPassword!();
              _isObscured = !_isObscured;
            } else {
              setState(() {
                _isObscured = !_isObscured;
              });
            }
          },
        ),
      ),
    );
  }
}

bool defineObscureText(bool? firstCondition, bool secondCondition) {
  if (firstCondition == null) {
    return secondCondition;
  }

  return firstCondition;
}

IconData defineIcon(bool? firstCondition, bool secondCondition) {
  if (firstCondition == null) {
    return secondCondition ? Icons.visibility : Icons.visibility_off;
  }

  return firstCondition ? Icons.visibility : Icons.visibility_off;
}
