import 'package:flutter/material.dart';

class ButtonHelp extends StatefulWidget {
  const ButtonHelp({super.key, this.onTap});

  final Function()? onTap;

  @override
  State<StatefulWidget> createState() => ButtonHelpState();
}

class ButtonHelpState extends State<ButtonHelp> {
  _onTap() {
    if (widget.onTap != null) widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Icon(
        Icons.info_outline_rounded,
        size: 40,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
