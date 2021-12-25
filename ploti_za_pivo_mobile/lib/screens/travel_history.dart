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
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 58, 97, 87), // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                  ),

                  onPressed: (){
                    var cart = context.read<Cart>();
                    cart.clearCart();
                    Navigator.pushNamed(context, '/travel_add_cart');
                  },
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Добавить счет',style: TextStyle(fontSize: 30),),
                      )
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
                    context.read<EventSequence>().calculateResult();
                    Navigator.pushNamed(context, '/travel_result');
                  },
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Рассчитать',style: TextStyle(fontSize: 30),),
                      )
                  )
              ),
            ],
          ),
        )
    );
  }

}
