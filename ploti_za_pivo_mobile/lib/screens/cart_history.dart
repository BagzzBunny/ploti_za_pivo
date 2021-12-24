import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_result.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_transactions.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class CartHistoryRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var cart = context.read<Cart>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Плати За Пиво'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [Column(

            children: [
              Text('История счета'),
              Text(cart.name),
              Container(

                  child: Column(
                    children: [
                      ChangeNotifierProvider(
                        create: (context) => PickProvider(),
                        builder: (context,widget) => MembersInfo(),
                      ),
                      Divider(),
                      ChangeNotifierProvider(
                        create: (context) => PickProvider(),
                        builder: (context,widget) => ProductsInfo(),
                      ),
                      Divider(),
                      ChangeNotifierProvider(
                        create: (context) => PickProvider(),
                        builder: (context,widget) => BindsInfo(),
                      ),
                      Divider(),
                      ChangeNotifierProvider(
                        create: (context) => PickProvider(),
                        builder: (context,widget) => TransactionsInfo(),
                      ),
                    ],
                  )
              ),

            ],
          )],
        )
    );
  }
}

class PickProvider extends ChangeNotifier{
  bool picked = false;
  pick(){
    picked = !picked;
    notifyListeners();
  }
}

class MembersInfo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    bool picked = context.watch<PickProvider>().picked;
    Cart cart = context.read<Cart>();
    return InkWell(
      onTap: (){context.read<PickProvider>().pick();},
      child: Container(
        child: picked ? Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Участники'),
                  Icon(Icons.keyboard_arrow_up),
                ]
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1)
              ),
              height: cart.members.length * 40,
              child: ListView.builder(

                itemCount: cart.members.length,
                itemBuilder: (context,index)=>Container(
                  height: 40,
                  child: Text(
                    cart.members[index].name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text('Участники'),
              Icon(Icons.keyboard_arrow_down),
            ]
        ),
      ),
    );
  }

}

class ProductsInfo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    bool picked = context.watch<PickProvider>().picked;
    Cart cart = context.read<Cart>();
    return InkWell(
      onTap: (){context.read<PickProvider>().pick();},
      child: Container(

        child: picked ? Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Список покупок'),
                  Icon(Icons.keyboard_arrow_up),
                ]
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 1)
                ),
                height: 80+cart.products.length*40,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 80,
                            child: Text('Позиция'),
                          ),
                          Container(
                            width: 80,
                            child: Text('Количество'),
                          ),
                          Container(
                            width: 80,
                            child: Text('Цена'),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      height: cart.products.length*40,
                      child: ListView.builder(
                          itemCount: cart.products.length,
                          itemBuilder: (context,index){
                            var product = cart.products[index];
                            return Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 80,
                                    child: Text(product.name),
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(product.qty.toString()),
                                  ),
                                  Container(
                                    width: 80,
                                    child: Text(product.price.toString()),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),
                    ),



                  ],
                )
            ),
          ],
        ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text('Список покупок'),
              Icon(Icons.keyboard_arrow_down),
            ]
        ),
      ),
    );
  }

}

class BindsInfo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    bool picked = context.watch<PickProvider>().picked;
    Cart cart = context.read<Cart>();
    return InkWell(
      onTap: (){context.read<PickProvider>().pick();},
      child: Container(
        child: picked ? Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Распределение покупок'),
                  Icon(Icons.keyboard_arrow_up),
                ]
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1)
              ),
              height: 600,
              child: ListView.builder(
                  itemCount: cart.members.length,
                  itemBuilder: (context,index){
                    return MemberSumUp(index);
                  }
              ),
            ),
          ],
        ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text('Распределение покупок'),
              Icon(Icons.keyboard_arrow_down),
            ]
        ),
      ),
    );
  }

}

class TransactionsInfo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    bool picked = context.watch<PickProvider>().picked;
    Cart cart = context.read<Cart>();
    List<dynamic> res = cart.calculateTransactions();
    List<Map<String,dynamic>> transactions = [];
    for (var b in res){
      String name = b[0];
      for (var pay in b[1].keys.toList()){
        transactions.add({'who':name,'amount':b[1][pay],'whom':pay});
      }
    }
    return InkWell(
      onTap: (){context.read<PickProvider>().pick();},
      child: Container(
        child: picked ? Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Text('Список покупок'),
                  Icon(Icons.keyboard_arrow_up),
                ]
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1)
              ),

              child: Column(
                children: [
                  TransactionLabel(),
                  Divider(),
                  Container(
                    height: cart.result.keys.toList().length * 40 + 45,
                    child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context,index){
                          return Transaction(transactions[index]);
                        }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ) : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text('Долги'),
              Icon(Icons.keyboard_arrow_down),
            ]
        ),
      ),
    );
  }

}