import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo.dart';

class TodoItem extends StatelessWidget {
  String title;
  TodoItem({Key key, this.title});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        title: new Text(title,
            textDirection: TextDirection.ltr,
            style: new TextStyle(color: Colors.white)),
        actions: <Widget>[new Icon(Icons.exit_to_app)],
      ),
      body: new TodoItemBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueGrey.shade900,
        onPressed: (){
          Navigator.push(context, new MaterialPageRoute(
            builder: (context)=> new TodoScreen(title: 'Add Todo')
          ));
        },
      ),
    );
  }
}

class TodoItemBody extends StatefulWidget {
  @override
  _TodoItemBodyState createState() => _TodoItemBodyState();
}

class _TodoItemBodyState extends State<TodoItemBody> {
  final String NOTE = 'note';
  List<String> todoItems=['ABC','ABC'];
  @override
  void initState() {
    super.initState();
    var intData = () async {
      var pref = await SharedPreferences.getInstance();
      var items = pref.getStringList(NOTE);
      todoItems=(items != null) ? items : todoItems ;
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.shade400,
      child: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (BuildContext context, int position) {
          return new Card(
            child: ListTile(
              title: Text(
                todoItems[position],
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
              ),
              leading: CircleAvatar(
                backgroundColor: _getRandomColor(),
                child: Text(
                  todoItems[position][0].toUpperCase(),
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getRandomColor() {
    int i = new Random().nextInt(7);
    switch (i) {
      case 0:
        return Colors.black;
      case 1:
        return Colors.blue.shade800;
      case 2:
        return Colors.cyan.shade900;
      case 3:
        return Colors.orange.shade900;
      case 4:
        return Colors.red.shade900;
      case 5:
        return Colors.cyan.shade900;
      case 6:
        return Colors.purple.shade900;
      default:
        return Colors.yellow.shade900;
    }
  }
}
