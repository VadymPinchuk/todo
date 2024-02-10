import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/todo/ui/todo_screen.dart';
import 'package:todo/todo/view_model/todo_view_model.dart';

/// Some namings to be used for better understanding and splitting the responsibilities
// Class with Scaffold - could be named Screen
// Body of the Scaffold - could be named Page and used inside of PageView for example
// Widget - is a Widget. Reusable or Single use component

/// Some possible ways to structure the code
// Create folders by features: todo/ details/ login/
// Create folder by Clean Architecture naming: presentation/ domain/ data/
// Combine todo/presentation/ todo/domain/ todo/data/
// presentation/todo/

/// It is main entry point where application is created and started
void main() => runApp(
      ChangeNotifierProvider(
        create: (BuildContext context) => TodoViewModel(),
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: const TodoScreen(),
        ),
      ),
    );
