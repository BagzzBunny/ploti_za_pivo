import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/src/provider.dart';

import 'item_builders/event_builder.dart';

class TravelHistoryRoute extends StatelessWidget {
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
              Text('История'),
              Text(context.read<EventSequence>().name),
              Container(
                height: 500,
                child: Column(
                  children: [
                    BuildItemLabel(),
                    Divider(),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: context.watch<EventSequence>().carts.length,
                        itemBuilder: (context,index) => BuildEventSequenceItem(index),
                      ),
                    ),

                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  var cart = context.read<Cart>();
                  cart.clearCart();
                  Navigator.pushNamed(context, '/travel_add_cart');
                },
                child: Text('Добавить счет'),
              ),
              ElevatedButton(
                onPressed: (){
                  context.read<EventSequence>().calculateResult();
                  Navigator.pushNamed(context, '/travel_result');
                },
                child: Text('Рассчитать'),
              )
            ],
          ),
        )
    );
  }

}
