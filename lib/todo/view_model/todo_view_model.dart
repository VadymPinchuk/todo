import 'package:flutter/material.dart';
import 'package:todo/todo/model/todo_item.dart';
import 'package:todo/todo/ui/todo_screen.dart';

/// Business logic for our [TodoScreen]
class TodoViewModel extends ChangeNotifier {
  final List<TodoItem> items = List.empty(growable: true);

  void addItem(String title) {
    items.add(TodoItem(title, false));
    notifyListeners();
  }

  void changeItem(int index, {String? title, bool? isChecked}) {
    if (index >= items.length) return;

    final todoItem = items.removeAt(index);
    final newItem = TodoItem(
      title ?? todoItem.title,
      isChecked ?? todoItem.isChecked,
    );
    items.insert(index, newItem);
    notifyListeners();
  }

  void removeItemAt(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}
