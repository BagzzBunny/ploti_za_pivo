import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/cart.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/src/provider.dart';

class TransactionsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return Scaffold(
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
                            itemCount: cart.result.keys.toList().length,
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
                  context.read<HistoryManager>().addCart(cart);
                  Navigator.popUntil(context, ModalRoute.withName('/history'));
                },
                child: Text('Перевести'),
              )
            ],
          ),
        )
    );
  }

}

class Transaction extends StatelessWidget {
  final int index;
  Transaction(this.index);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var mName = cart.result.keys.toList()[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(mName),
        Text(cart.result[mName].toString()),
        Text('Борис работает'),
      ],
    );
  }

}