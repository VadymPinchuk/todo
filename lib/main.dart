import 'package:flutter/material.dart';

/// SOLID
/// Lifecycle
/// Refactoring
/// Architecture?
/// UI = f(State)

void main() => runApp(
      MaterialApp(
        theme: ThemeData.dark(),
        home: TodoApp(),
      ),
    );

class TodoApp extends StatefulWidget {
  @override
  TodoAppState createState() => TodoAppState();
}

class TodoAppState extends State<TodoApp> {
  final List<String> mTL = [];
  final List<bool> mTCL = [];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple TODO List')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index < mTL.length) {
            return Dismissible(
              key: Key(mTL[index]),
              onDismissed: (direction) {
                // TODO: it
              },
              background: Container(
                  color: Colors.red, child: Row(children: [Spacer(), Icon(Icons.delete)])),
              child: TodoItemWidget(
                title: mTL[index],
                isCompleted: mTCL[index],
                onTapped: () {
                  controller.text = mTL[index]; // Pre-fill the text field with the current task
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text('Edit TODO'),
                            content: TextField(
                              controller: controller,
                              decoration: InputDecoration(hintText: 'Edit your task...'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('CANCEL'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  controller.clear();
                                },
                              ),
                              TextButton(
                                  child: Text('UPDATE'),
                                  onPressed: () {
                                    if (controller.text.isNotEmpty) {
                                      setState(() {
                                        mTL[index] = controller.text;
                                      });
                                      controller.clear();
                                    }
                                    Navigator.of(context).pop();
                                  })
                            ]);
                      });
                },
                onCompletedChanged: (value) {
                  mTCL[index] = value;
                  setState(() {});
                },
              ),
            );
          }
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New TODO'),
                content: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Enter something to do...'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.clear();
                    },
                  ),
                  TextButton(
                    child: Text('ADD'),
                    onPressed: () {
                      final task = controller.text;
                      if (task.isNotEmpty) {
                        setState(() {
                          mTL.add(task);
                          mTCL.add(false);
                        });
                        controller.clear();
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final VoidCallback? onTapped;
  final ValueChanged<bool> onCompletedChanged;

  const TodoItemWidget({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.onTapped,
    required this.onCompletedChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            Checkbox(
              value: isCompleted,
              onChanged: (value) {
                if (value == null)
                  return;
                else
                  onCompletedChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
