import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:ploti_za_pivo_mobile/screens/add_cart_from_history.dart';
import 'package:provider/src/provider.dart';

class BuildHistoryItem extends StatelessWidget{
  late int index;
  BuildHistoryItem(this.index);

  @override
  Widget build(BuildContext context) {
    var history = context.watch<HistoryManager>();
    var event = history.items[index];
    return BuildItem(event);
  }

}

class BuildEventSequenceItem extends StatelessWidget{
  late int index;
  BuildEventSequenceItem(this.index);

  @override
  Widget build(BuildContext context) {
    var sequence = context.watch<EventSequence>();
    var event = sequence.carts[index];
    return BuildItem(event);
  }

}

class BuildItem extends StatelessWidget{
  final Event event;

  const BuildItem(this.event,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (event is Cart){
          var activeCart = context.read<Cart>();
          activeCart.setCart(event as Cart);
          Navigator.pushNamed(context, '/cart_history');
        }
        else if (event is EventSequence){
          var activeEvent = context.read<EventSequence>();
          activeEvent.setEventSequence(event as EventSequence);
          Navigator.pushNamed(context, '/travel_history');
        }

      },
      child: AspectRatio(
        aspectRatio: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 40,
              child: event is Cart ? Icon(Icons.description) : Icon(Icons.airplanemode_active),
            ),
            Container(
              width: 100,
              child: Text(event.date.day.toString() + '-' + event.date.month.toString() + '-' + event.date.year.toString()),
            ),
            Container(
              width: 40,
              child: Text(event.members.length.toString()),
            ),
            Container(
              width: 100,
              child: Text(event.getCostSum().toString()),
            ),
            Container(
              width: 40,
              child: Icon(Icons.verified),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildCartAddItem extends StatelessWidget{
  late int index;
  BuildCartAddItem(this.index);

  @override
  Widget build(BuildContext context) {
    var history = context.watch<HistoryManager>();
    var event = history.items.whereType<Cart>().toList()[index];
    var pickController = context.watch<PickController>();
    var picked = pickController.isPicked(index);
    return BuildAddItem(event,picked,index);
  }
}

class BuildAddItem extends StatelessWidget{
  final Event event;
  final bool picked;
  final int index;

  const BuildAddItem(this.event,this.picked, this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if (event is Cart){
          var activeCart = context.read<Cart>();
          activeCart.setCart(event as Cart);
          Navigator.pushNamed(context, '/cart_history');
        }
        else if (event is EventSequence){
          var activeEvent = context.read<EventSequence>();
          activeEvent.setEventSequence(event as EventSequence);
          Navigator.pushNamed(context, '/travel_history');
        }

      },
      child: AspectRatio(
        aspectRatio: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 40,
              child: event is Cart ? Icon(Icons.description) : Icon(Icons.airplanemode_active),
            ),
            Container(
              width: 100,
              child: Text(event.date.day.toString() + '-' + event.date.month.toString() + '-' + event.date.year.toString()),
            ),
            Container(
              width: 40,
              child: Text(event.members.length.toString()),
            ),
            Container(
              width: 100,
              child: Text(event.getCostSum().toString()),
            ),
            Container(
              width: 40,
              child: Checkbox(
                value: picked,
                onChanged: (value){
                  context.read<PickController>().pick(index);
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}

class BuildItemLabel extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 40,
            child: Text('Тип Счета'),
          ),
          Container(
            width: 100,
            child: Text('Дата'),
          ),
          Container(
            width: 40,
            child: Text('Кол-во участников'),
          ),
          Container(
            width: 100,
            child: Text('Общая сумма'),
          ),
          Container(
            width: 40,
            child: Text('Статус'),
          ),

        ],
      ),
    );
  }
}