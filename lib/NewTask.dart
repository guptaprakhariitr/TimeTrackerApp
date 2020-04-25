import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NewTask extends StatefulWidget {
  final Color color=Colors.black54;
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _formKey = GlobalKey<FormState>();
   String Taskname;
  final myController = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;
  Future<void> _SetCounter(String srt) async {
    final SharedPreferences prefs = await _prefs;
    //final int counter = (prefs.getInt(srt) ?? 0);
    int counter=(prefs.getInt("counter") ?? -1)+1;
    prefs.setInt("counter", counter);
    var now = new DateTime.now();
    prefs.setString(counter.toString(),srt);
    prefs.setInt(counter.toString()+"year", now.year);
    prefs.setInt(counter.toString()+"month", now.month);
    prefs.setInt(counter.toString()+"day", now.day);
    prefs.setInt(counter.toString()+"hour", now.hour);
    prefs.setInt(counter.toString()+"minute", now.minute);
    prefs.setInt(counter.toString()+"second", now.second);
    return;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add a new Task",
        style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,),
    ),
        backgroundColor: NewTask().color,
     elevation: 10,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
            ),
          ),
          Expanded(
            child: Center(
              child:Form(
                  key:_formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        cursorColor: Colors.blue,
                        decoration: const InputDecoration(
                          hintText: 'Enter your Task',
                          fillColor: Colors.lightBlue,
                          focusColor: Colors.indigo,
                          hoverColor: Colors.indigo,
                        ),
                        keyboardAppearance: Brightness.light,
                        controller: myController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },

                      ),
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: RaisedButton(
                          child: Text("Add The Task",
                          style: TextStyle(
                            color: Colors.white
                          ),),
                          onPressed: () async{
                            SharedPreferences prefs = await _prefs;
    if (_formKey.currentState.validate()) {
                    await _SetCounter(myController.text);
                    showDialog(context: context,builder: (context){
                      return AlertDialog(
                        content: Text(prefs.get(prefs.get("counter").toString()) + " Is Marked As New Task" ,

                        ),
                      );
                    });
                    }
                        myController.clear();
                          },
                          color: Colors.lightBlue,
                        ),
                      )
                    ],
                  ),
              ),
              ),
            ),
          Expanded(
            child: SizedBox(
            ),
          ), ],
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}
