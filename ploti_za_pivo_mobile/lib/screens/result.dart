import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/cart.dart';
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
                  height: 600,
                  child: Column(
                    children: [
                      Divider(),
                      Container(
                        height: 500,
                        child: ListView.builder(
                            itemCount: cart.members.length,
                            itemBuilder: (context,index){
                              return MemberSumUp(index);
                            }
                        ),
                      ),

                    ],
                  )
              ),

              ElevatedButton(
                onPressed: (){
                  context.read<Cart>().calculateResult();
                  Navigator.pushNamed(context, '/transactions');
                },
                child: Text('Далее'),
              )
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
        Text(member.name),
        Container(
          height: 100,
          child: ListView.builder(
            itemCount: cart.getMemberBinds(member.name).length,
            itemBuilder: (context,innerindex) {
              return ProductSumUp(innerindex,member.name);
            },
          ),
        ),

        Divider(),
        Text('Итого: ' + cart.getMemberBindsSum(member.name).toString()),
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
    return Text(binds[index].product.name + ' ' + binds[index].qty.toString());
  }
}