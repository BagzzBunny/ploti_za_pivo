import 'package:flutter/material.dart';

class HistoryRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Плати За Пиво'),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('История'),
                Container(
                  height: 500,
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/add_members');
                  },
                  child: Text('Начать новую покупку'),
                )
              ],
            ),
          )
      ),
    );
  }

}