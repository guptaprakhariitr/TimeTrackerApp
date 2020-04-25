import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class listMain extends StatefulWidget {

  @override
  _listMainState createState() => _listMainState();
}

class _listMainState extends State<listMain> {
  int stop=1,c=0;
  Timer timer;
  Icon iconPause=new Icon(Icons.pause);
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Icon iconPlay=new Icon(Icons.play_arrow);
  Listing lista=new Listing();
  Future<int> _counter;
  Color color=Colors.black54;
  static Listing listing=new Listing();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Tracker",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: color,
        ),
      body: new ListView.builder(
          //itemCount: stop,
          itemBuilder: (BuildContext context,int index)
      {return  FutureBuilder(
            future: listing.listFill(index),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.none: return Text("Not There");
                case ConnectionState.waiting: return Text('');
                default:
                  if (snapshot.hasError)
                   { return new Text('Error: ${snapshot.error}');}
                  else if( snapshot.data.task !=null)
                    {
                     print("STOP" + stop.toString());
                    return new Container(
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  iconSize: 15,
                                  onPressed: (){

                                  },
                                ),
                                SizedBox(height: 5,),
                                //Task
                                Text(
                                  snapshot.data.task,
                                )
                              ],
                            ),
                            //time
                            Text(snapshot.data.time)
                          ],
                        ),
                      ),
                    );
                 }
                  else
                    {
                      return Text('');
                    }
              }
            })
        ;
      }
      )



     ,
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                        Navigator.pushNamed(context, '/NewTask').whenComplete(() => _refresh());
                            },
                    backgroundColor: color,
                    child: Icon(
                      Icons.add,
                    ),

                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                ),
              );
  }
  void _refresh()
  {print("refreshed");
    setState(() {
    });
  }
  @override
  void initState(){
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      stop=(prefs.getInt("counter") ?? 1);
      print(stop.toString()+"  scscsd");
      return (prefs.getInt('counter') ?? 1);
    });
    setState(() {
      const oneSecond = const Duration(seconds: 10);
      new Timer.periodic(oneSecond, (Timer t) =>setState((){

      }));
    });
  }

}

class CardItem  {
  String task,time;
   int count;
  Icon iconUsed=new Icon(Icons.play_arrow);
  CardItem(this.task,this.time,this.count);
}
class Listing {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<CardItem> listFill(int index) async
  {
    final SharedPreferences prefs = await _prefs;
   int count=await prefs.get("counter");
   print(index.toString()+"  ****   "+ count.toString());
   if(count!=null){
   if(index<=count){
      var now =new DateTime.now();
      String task =await prefs.get(index.toString());
      print(task);
      var then =new DateTime(prefs.get(index.toString() + "year"),
          prefs.get(index.toString() + "month"),
          prefs.get(index.toString() + "day"),
          prefs.get(index.toString() + "hour"),
          prefs.get(index.toString() + "minute"),
          prefs.get(index.toString() + "second"));
     String time = now.difference(then).toString().substring(0,7);
     CardItem cardItem=new CardItem(task,time,count);
      return cardItem;}
   else {
     CardItem cardItem=new CardItem(null,null,null);
     return cardItem;
   }
   }
   else {
     CardItem cardItem=new CardItem(null,null,null);
     return cardItem;
   }
  }
}

