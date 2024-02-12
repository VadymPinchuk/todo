import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common_ui/custom_footer.dart';
import 'package:todo/todo/model/todo_item.dart';
import 'package:todo/todo/view_model/todo_view_model.dart';

/// KISS (Keep It Simple, Stupid)
/// DRY (Don't Repeat Yourself)
///
/// Main screen with List of the [ListTile]
class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple TODO List')),
      body: Selector<TodoViewModel, List<TodoItem>>(
        shouldRebuild: listEquals,
        selector: (BuildContext context, TodoViewModel viewModel) {
          return viewModel.items;
        },
        builder: (BuildContext context, todoList, Widget? child) {
          return ListView.builder(
            itemCount: todoList.length + 1,
            itemBuilder: (context, index) {
              if (index < todoList.length) {
                return listItem(
                  context,
                  todoList[index],
                  index,
                );
              } else if (index == todoList.length) {
                return const CustomFooter(
                  'We have reached end',
                  Colors.green,
                );
              }
              return null;
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTodoDialog(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// ListTile item to be displayed for each [TodoItem]
  Widget listItem(BuildContext context, TodoItem item, int index) {
    final model = context.read<TodoViewModel>();
    return Dismissible(
      key: Key(item.title),
      onDismissed: (_) {
        model.removeItemAt(index);
      },
      background: Container(
        color: Colors.red,
        child: const Row(
          children: [
            Spacer(),
            Icon(Icons.delete),
          ],
        ),
      ),
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 16.0,
            decoration: item.isChecked ? TextDecoration.lineThrough : null,
          ),
        ),
        leading: Checkbox(
          value: item.isChecked,
          onChanged: (bool? newCheckState) {
            if (newCheckState == null) {
              return;
            } else {
              model.changeItem(index, isChecked: newCheckState);
            }
          },
        ),
        onTap: () => showTodoDialog(context, input: item.title, index: index),
      ),
    );
  }

  /// We are showing Dialog to create new To Do item and add to the list
  /// This dialog is used also to edit To Do item, but input and index should be mentioned then
  void showTodoDialog(BuildContext context, {String? input, int index = 0}) {
    final TextEditingController controller = TextEditingController();
    final bool isNewTodo = input == null || input.isEmpty;
    if (!isNewTodo) {
      controller.text = input;
    }
    final TodoViewModel model = context.read<TodoViewModel>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isNewTodo ? 'New TODO' : 'Edit TODO'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: isNewTodo ? 'Enter something to do...' : 'Edit your task...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                controller.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isNewTodo ? 'ADD' : 'SAVE'),
              onPressed: () {
                final task = controller.text;
                if (task.isNotEmpty) {
                  if (isNewTodo) {
                    model.addItem(task);
                  } else {
                    model.changeItem(index, title: task);
                  }
                  controller.clear();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
