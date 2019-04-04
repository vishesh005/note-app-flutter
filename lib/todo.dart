import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoScreen extends StatelessWidget {
  final String title;

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
      ),
      body: new _TodoBody(),
    );
  }
}

class _TodoBody extends StatefulWidget {
  _TodoBodyState state = _TodoBodyState();

  @override
  _TodoBodyState createState() => state;
}

class _TodoBodyState extends State<_TodoBody> {
  final TextEditingController _noteController = new TextEditingController();
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
              onSubmitted: (str) => _saveNote(),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }

  _saveNote() async {
    String message = _noteController.text;
    _noteController.clear();
    if (message.isNotEmpty) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String> list = pref.getStringList(NOTE);
      if (list == null) list = new List();
      list.add(message);
      await pref.setStringList(NOTE, list);
      showToast("Note Saved sucessfully");
      Navigator.pop(context);
    }
  }
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black38,
      textColor: Colors.white,
      fontSize: 16.0);
}
