import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/src/provider.dart';

class ResultRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = context.read<Cart>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Плати За Пиво'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Проверьте результаты'),
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 58, 97, 87), // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                  ),

                  onPressed: (){
                    cart.calculateResult();
                    if (context.read<HistoryManager>().editingSequence){
                      context.read<EventSequence>().addCart(cart);
                      context.read<HistoryManager>().editingSequence = false;
                      Navigator.popUntil(context, ModalRoute.withName('/travel_history'));
                    } else {
                      Navigator.pushNamed(context, '/cart_transactions');
                    }

                  },
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Посмотреть переводы',style: TextStyle(fontSize: 20),),
                      )
                  )
              ),

            ],
          ),
        )
    );
  }

}

class MemberSumUp extends StatelessWidget {
  final int index;
  MemberSumUp(this.index);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    var member = cart.members[index];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
              width: 150,
              height: 50,
              margin: EdgeInsets.all(5),
              color: Color.fromARGB(255, 215, 255, 215) ,
              child:Align(
                alignment: Alignment.center,
                child: Text(member.name,style: TextStyle(fontSize: 18),),
              )
          ),
        ),

        Container(
          height: cart.getMemberBinds(member.name).length*20.0,
          child: ListView.builder(
            itemCount: cart.getMemberBinds(member.name).length,
            itemBuilder: (context,innerindex) {
              return ProductSumUp(innerindex,member.name);
            },
          ),
        ),

        Divider(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Итого: ' + cart.getMemberBindsSum(member.name).toString()),
        ),

        SizedBox(
          height: 20,
        )
      ],
    );
  }

}

class ProductSumUp extends StatelessWidget {
  final int index;
  final String mName;

  ProductSumUp(this.index, this.mName);

  @override
  Widget build(BuildContext context) {
    var binds = context.read<Cart>().getMemberBinds(mName);
    return Container(
        width: 80,
        height: 40,
        margin: EdgeInsets.all(2),
        color: Color.fromARGB(255, 215, 255, 215) ,
        child:Text(binds[index].product.name + ' ' + binds[index].qty.toString(),textAlign:TextAlign.center,style: TextStyle(fontSize: 14),)
    );
  }
}