import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/src/provider.dart';

class TransactionsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    List<Map<String,dynamic>> transactions = [];
    if (cart.calculateTransactions() is String){

    } else {
      List<dynamic> res = cart.calculateTransactions();

      for (var b in res){
        String name = b[0];
        for (var pay in b[1].keys.toList()){
          transactions.add({'who':name,'amount':b[1][pay],'whom':pay});
        }
      }
    }

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
                    children: !transactions.isEmpty ? [
                      TransactionLabel(),

                      Divider(),
                      Container(
                        height: 400,
                        child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context,index){
                              return Transaction(transactions[index]);
                            }
                        ),
                      ),

                    ] : [
                      TransactionLabel(),

                      Divider(),
                      
                      Text('Не удалось вычислить переводы, проверьте сумму всех затрат')
                    ],
                  )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 58, 97, 87), // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                  ),

                  onPressed: (){
                    context.read<HistoryManager>().addEvent(cart);
                    Navigator.popUntil(context, ModalRoute.withName('/history'));
                  },
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Добавить в историю',style: TextStyle(fontSize: 20),),
                      )
                  )
              ),

            ],
          ),
        )
    );
  }

}

class TransactionLabel extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 80,
            child: Text('Кто?'),
          ),
          Container(
            width: 80,
            child: Text('Сколько?'),
          ),
          Container(
            width: 80,
            child: Text('Кому?'),
          ),
        ],
      ),
    );
  }

}

class Transaction extends StatelessWidget {
  final Map<String,dynamic> transaction;
  Transaction(this.transaction);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 80,
            child: Text(transaction['who']),
          ),
          Container(
            width: 80,
            child: Text(transaction['amount'].toString()),
          ),
          Container(
            width: 80,
            child: Text(transaction['whom']),
          ),
        ],
      ),
    );
  }

}