import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoScreen extends StatelessWidget {
  String title;

  TodoScreen({Key key, String this.title});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        title: new Text(title,
            textDirection: TextDirection.ltr,
            style: new TextStyle(color: Colors.white)),
        actions: <Widget>[Icon(Icons.save)],
      ),
      body: new TodoBody(),
    );
  }
}

class TodoBody extends StatefulWidget {
  @override
  _TodoBodyState createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  TextEditingController _noteController = new TextEditingController();
  final String NOTE = 'note';
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blueGrey.shade400,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: 'Enter Your Note here',
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 100,
              controller: _noteController,
            ),
          ),
        ],
      ),
    );
  }

  _saveNote() async {
    if (_noteController.text.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String> list = pref.getStringList(NOTE);
      if (list == null) list = new List();
      pref.setStringList(NOTE, list);
      pref.commit();
      showToast("Note Saved sucessfully");
      Navigator.pop(context);
    }
  }
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black38,
      textColor: Colors.white,
      fontSize: 16.0);
}
