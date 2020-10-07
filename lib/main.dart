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
        child: IconButton(
          onPressed: () {
            print('Да разъебись ты триебучим проебом хуепуполо залупоглазое');
          },
          icon: Icon(Icons.alternate_email),
          color: Colors.amber
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Нахуй всё'),
        backgroundColor: Colors.blueAccent[200],
      ),
    );
  }
}
