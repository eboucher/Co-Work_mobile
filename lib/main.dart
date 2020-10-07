import 'package:flutter/material.dart';

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
      body: Center(
        child: Image.asset('assets/coworking-1.jpg')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Нахуй всё'),
        backgroundColor: Colors.blueAccent[200],
      ),
    );
  }
}
