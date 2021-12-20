import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/src/provider.dart';

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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Дата'),
                          Text('Кол-во участников'),
                          Text('Общая сумма'),
                          Text('Статус'),
                        ],
                      ),
                      Container(
                        height: 400,
                        child: ListView.builder(
                          itemCount: context.read<HistoryManager>().items.length,
                          itemBuilder: (context,index) => BuildHistoryItem(index),
                        ),
                      ),

                    ],
                  ),
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

class BuildHistoryItem extends StatelessWidget{
  late int index;
  BuildHistoryItem(this.index);

  @override
  Widget build(BuildContext context) {
    var history = context.read<HistoryManager>();
    var cart = history.items[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(cart.date.toString()),
        Text(cart.members.length.toString()),
        Text(cart.getCostSum().toString()),
        Icon(Icons.verified),
      ],
    );
  }

}