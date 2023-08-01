import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'display_text_field.dart';

class DisplayTextFieldBox extends StatefulWidget {
  const DisplayTextFieldBox({
    Key? key,
    required this.label,
    required this.value,
    this.callback,
    this.isCard = true,
    this.editable = true,
  }) : super(key: key);
  final String label;
  final String value;
  final bool isCard;
  final bool editable;
  final void Function(String)? callback;

  @override
  State<DisplayTextFieldBox> createState() => _DisplayTextFieldBoxState();
}

class _DisplayTextFieldBoxState extends State<DisplayTextFieldBox> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onDoubleTap: () {
        if (widget.editable) {
          cardKey.currentState?.toggleCard();
          if (cardKey.currentState?.isFront ?? false) {
            _focusNode.unfocus();
          }
        }
      },
      child: IntrinsicWidth(
        child: FlipCard(
          key: cardKey,
          flipOnTouch: false,
          front: Card(
            elevation: widget.isCard ? null : 0,
            color: themeData.colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: DisplayTextField(label: widget.label, value: widget.value),
            ),
          ),
          back: TextField(
            onSubmitted: widget.callback,
            focusNode: _focusNode,
            style: TextStyle(
              color: themeData.primaryColor,
            ),
            decoration: InputDecoration(
              label: Text(widget.label),
              hintText: widget.value,
              hintStyle: TextStyle(
                color: themeData.primaryColor,
              ),
              labelStyle: TextStyle(
                color: themeData.primaryColor,
              ),
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
