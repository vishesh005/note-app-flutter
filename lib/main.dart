import 'package:flutter/material.dart';
import './todo_item.dart';

void main()=>runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: new TodoItem(title: 'Todo App',),
    );
  }
}