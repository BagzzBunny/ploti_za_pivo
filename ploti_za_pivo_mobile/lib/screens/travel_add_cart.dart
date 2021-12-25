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
              Align(
                alignment: Alignment.center,
                child: Text('Выберите нужные счета из истории, чтобы сделать перерасчет, или добавьте новый счет',textAlign:TextAlign.center,style: TextStyle(fontSize: 18),),
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
                    Navigator.pushNamed(context, '/add_cart_from_history');
                  },
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Выбрать из истории',style: TextStyle(fontSize: 18),),
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
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Создать новый',style: TextStyle(fontSize: 30),),
                      )
                  )
              ),

            ],
          ),
        )
    );
  }

}