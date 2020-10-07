import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Co\'Work'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[200],
      ),
      body: Center(
        child: Text(
          'Пиздун ебаный чтобы ты хуй на жопу закрипил ебан трёхдневный.',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[600],
            fontFamily: 'IndieFlower',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Нахуй всё'),
        backgroundColor: Colors.blueAccent[200],
      ),
    ),
  ));
}