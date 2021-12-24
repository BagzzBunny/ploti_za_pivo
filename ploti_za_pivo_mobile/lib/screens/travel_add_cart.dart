import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';
import 'package:provider/provider.dart';

class TravelAddCartRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Плати За Пиво'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Выберите нужные счета из истории, чтобы сделать перерасчет, или добавьте новый счет'),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/add_cart_from_history');
                },
                child: Text('Выбрать из истории'),
              ),
              ElevatedButton(
                onPressed: (){
                  var cart = context.read<Cart>();
                  cart.clearCart();
                  cart.members = context.read<EventSequence>().members;
                  for (Member member in cart.members){
                    member.payed = false;
                    member.amountPayed = 0;
                  }
                  context.read<HistoryManager>().editingSequence = true;

                  Navigator.pushNamed(context, '/add_members');
                },
                child: Text('Создать новый'),
              )
            ],
          ),
        )
    );
  }

}