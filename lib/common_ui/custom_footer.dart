import 'package:flutter/material.dart';

/// To Do Footer used under the To Do List
class CustomFooter extends StatelessWidget {
  const CustomFooter(this._text, this._iconColor, {super.key});

  final String _text;
  final Color _iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.connecting_airports_sharp,
            color: _iconColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_text),
        ),
      ],
    );
  }
}
