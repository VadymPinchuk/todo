import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/todo/ui/todo_screen.dart';
import 'package:todo/todo/view_model/todo_view_model.dart';

/// SOLID
/// Lifecycle
/// Refactoring
/// Architecture?
/// UI = f(State)

/// Scaffold - TodoScreen
/// Body - Page - PageView
/// Widget -

/// It is main entry point where application is created and started

/// Create folders by features: todo/ details/ login/
/// Create folder by Clean Architecture naming: presentation/ domain/ data/
/// Combine todo/presentation/ todo/domain/ todo/data/
/// presentation/todo/
void main() => runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => TodoViewModel(),
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: const TodoScreen(),
        ),
      ),
    );
