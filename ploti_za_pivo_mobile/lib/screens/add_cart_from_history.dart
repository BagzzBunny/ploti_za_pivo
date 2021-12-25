import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'item_builders/event_builder.dart';

class AddCartFromHistoryRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var history = context.watch<HistoryManager>();
    return ChangeNotifierProvider(
      create: (context) => PickController(),
      builder: (context,widget) => Scaffold(
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
                      BuildItemLabel(),
                      Divider(),
                      Container(
                        height: 400,
                        child: ListView.builder(
                          itemCount: history.items.whereType<Cart>().toList().length,
                          itemBuilder: (context,index) => BuildCartAddItem(index),
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
                      List<Cart> picked = [];

                      for (int index in context.read<PickController>().picked){
                        picked.add(history.items.whereType<Cart>().toList()[index]);
                      }
                      for (Cart cart in picked){
                        history.removeEvent(cart);
                        context.read<EventSequence>().addCart(cart);
                      }
                      Navigator.pushNamed(context, '/travel_history');
                    },
                    child: Container(
                        width: 250,
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Добавить в путешествие',style: TextStyle(fontSize: 20),),
                        )
                    )
                ),

              ],
            ),
          )
      ),
    );
  }

}

class PickController extends ChangeNotifier{
  List<int> picked = [];

  pick(int index){
    if (picked.contains(index)){
      picked.remove(index);
    } else {
      picked.add(index);
    }
    notifyListeners();
  }

  isPicked(int index) {
    return picked.contains(index);
  }
}

