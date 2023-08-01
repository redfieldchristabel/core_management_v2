import 'package:flutter/material.dart';

/// this widget is use to show data that can are editable cause if user double click this widget it will trigger text ile area
/// you can also close text field area by not given any [callback].
/// in text field area, all [value] will be hint text.
class DisplayTextField extends StatelessWidget {
  const DisplayTextField(
      {Key? key, required this.label, required this.value, this.callback})
      : super(key: key);

  final String label;
  final String value;
  final void Function(String)? callback;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: themeData.textTheme.bodySmall!.copyWith(color: Colors.black),
            ),
            TextSpan(
              text: value,
              style: themeData.textTheme.bodySmall!
                  .copyWith(color: Colors.black54, overflow: TextOverflow.clip),
            ),
          ],
        ),
      ),
    );
  }
}
