import 'package:flutter/material.dart';

class TransactionsRoute extends StatelessWidget {
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
                Text('Переводы'),
                Container(
                    height: 500,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Кто?'),
                            Text('Сколько?'),
                            Text('Кому?'),
                          ],
                        ),
                        Divider(),
                        Container(
                          height: 400,
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context,index){
                                return Transaction(index);
                              }
                          ),
                        ),

                      ],
                    )
                ),

                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/history');
                  },
                  child: Text('Перевести'),
                )
              ],
            ),
          )
      ),
    );
  }

}

class Transaction extends StatelessWidget {
  final int index;
  Transaction(this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Имя' + index.toString()),
        Text('Сумма' + index.toString()),
        Text('Кому' + index.toString()),
      ],
    );
  }

}