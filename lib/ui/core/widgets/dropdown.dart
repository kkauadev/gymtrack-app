import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String? selectedValue;
  final Iterable<String> items;
  final ValueChanged<String> onSelected;
  final Widget? label;

  const Dropdown({
    super.key,
    required this.items,
    this.selectedValue,
    required this.onSelected,
    this.label,
  });

  @override
  createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late String? _selectedValue;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyLarge;
    TextStyle? priTextStyle = Theme.of(context).primaryTextTheme.bodyLarge;
    Color? color = Theme.of(context).colorScheme.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[widget.label!],
        PopupMenuButton<String>(
          onSelected: (value) {
            setState(() {
              _selectedValue = value;
              _errorText = null;
            });
            widget.onSelected(value);
          },
          position: PopupMenuPosition.under,
          constraints: const BoxConstraints(minWidth: double.infinity),
          itemBuilder: (context) => widget.items
              .map((item) => generateItem(item, priTextStyle, color, textStyle))
              .toList(),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _errorText != null
                    ? Theme.of(context).colorScheme.error
                    : Colors.grey[200]!,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedValue ?? 'Select an option'),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
      ],
    );
  }

  PopupMenuItem<String> generateItem(
      String item, TextStyle? priTextStyle, Color color, TextStyle? textStyle) {
    return PopupMenuItem<String>(
      value: item,
      child: Row(
        spacing: 8,
        children: [
          Icon(
            Icons.check,
            color: _selectedValue == item ? Colors.blue : Colors.transparent,
          ),
          Text(
            item,
            style: _selectedValue == item
                ? priTextStyle?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  )
                : textStyle,
          ),
        ],
      ),
    );
  }
}
