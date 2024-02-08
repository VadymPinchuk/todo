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
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<String> _todoList = [];
  final List<bool> _todoCheckList = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple TODO List')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index < _todoList.length) {
            return ListTile(
              title: Text(
                _todoList[index],
                style: TextStyle(
                  decoration: _todoCheckList[index] ? TextDecoration.lineThrough : null,
                ),
              ),
              leading: Checkbox(
                value: _todoCheckList[index],
                onChanged: (bool? newValue) {
                  setState(() {
                    _todoCheckList[index] = newValue!;
                  });
                },
              ),
            );
          }
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('New TODO'),
              content: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: 'Enter something to do...'),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _textFieldController.clear();
                  },
                ),
                TextButton(
                  child: Text('ADD'),
                  onPressed: () {
                    final task = _textFieldController.text;
                    if (task.isNotEmpty) {
                      setState(() {
                        _todoList.add(task);
                        _todoCheckList.add(false);
                      });
                      _textFieldController.clear();
                    }
                    ;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ),
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
