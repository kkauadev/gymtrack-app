import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.labelStyle,
  });

  final String label;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final Icon? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: icon != null
            ? ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      backgroundColor ?? Theme.of(context).colorScheme.primary,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(16),
                  ),
                  padding: padding ??
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                icon: icon,
                label: Text(
                  label,
                  style: labelStyle ??
                      TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                onPressed: onPressed,
              )
            : ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(12),
                  ),
                  padding: padding ??
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
                child: Text(
                  label,
                  style: labelStyle ??
                      TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ));
  }
}
