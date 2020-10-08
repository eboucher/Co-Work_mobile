import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Co\'Work'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[200],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Мне пиздец'),
          FlatButton(
            onPressed: (){},
            color: Colors.amber,
            child: Text('Всем похуй'),
          ),
          Container(
            color: Colors.cyan,
            padding: EdgeInsets.all(30.0),
            child: Text('Ебанута какая-то'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Нахуй всё'),
        backgroundColor: Colors.blueAccent[200],
      ),
    );
  }
}
