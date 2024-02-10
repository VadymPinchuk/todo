import 'package:flutter/widgets.dart';

/// Data model to be used in To Do list to init ListTiles
@immutable
class TodoItem {
  const TodoItem(this.title, this.isChecked);

  final String title;
  final bool isChecked;
}
