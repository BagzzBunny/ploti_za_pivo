import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/bind_info.dart';
import 'package:ploti_za_pivo_mobile/models/cart.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class CartAssertRoute extends StatefulWidget{
  @override
  _CartAssertRouteState createState() {
    return _CartAssertRouteState();
  }

}

class _CartAssertRouteState extends State<CartAssertRoute> {
  String mName = '';
  String pName = '';

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Плати За Пиво'),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Сопоставьте участников покупок и позиции чека'),
                Container(
                    height: 500,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Имя'),
                            Text('Позиция'),
                          ],
                        ),
                        Divider(),
                        Container(
                          height: 400,
                          child: ListView.builder(
                              itemCount: cart.binds.length,
                              itemBuilder: (context,index){
                                return AssertPosition(index);
                              }
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Новая позиция чека'),
                              content: FocusTraversalGroup(
                                child: Form(
                                    autovalidateMode: AutovalidateMode.always,
                                    onChanged: () {
                                      //Form.of(primaryFocus!.context!)!.save();
                                    },
                                    child: Column(
                                      children: [
                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Имя',
                                          ),
                                          value: mName == '' ? null : mName,
                                          onChanged: (String? value) {
                                            mName = value!;
                                          },
                                          items: cart.members
                                              .map((Member member) {
                                            return DropdownMenuItem<String>(
                                              value: member.name,
                                              child: Text(member.name),
                                            );
                                          }).toList(),
                                        ),
                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Позиция',
                                          ),
                                          value: pName == '' ? null : pName,
                                          onChanged: (String? value) {
                                            setState(() {
                                              pName = value!;
                                              var product = context.read<Cart>().getProduct(pName);
                                              context.read<BindInfo>().updateItems(product == null ? 0 : product.qty);

                                            });
                                          },

                                          items: cart.products
                                              .map((Product product) {
                                            return DropdownMenuItem<String>(
                                              value: product.name,
                                              child: Text(product.name),
                                            );
                                          }).toList(),

                                        ),
                                        DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Позиция',
                                          ),
                                          value: context.watch<BindInfo>().selected == 0 ? null : context.watch<BindInfo>().selected.toString(),
                                          onChanged: (String? value) {
                                            context.read<BindInfo>().selected = int.tryParse(value!)!;
                                          },
                                          items: context.watch<BindInfo>().items,
                                        ),
                                      ],
                                    )

                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    mName = '';
                                    pName = '';
                                    context.read<BindInfo>().updateItems(0);

                                    Navigator.pop(context);
                                  },
                                  child: const Text('Отмена'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cart.addBind(Bind(cart.getMember(mName),cart.getProduct(pName),context.read<BindInfo>().selected));
                                    mName = '';
                                    pName = '';
                                    context.read<BindInfo>().updateItems(0);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Добавить'),
                                ),
                              ],
                            ),
                          ),
                          child: Text('Добавить'),
                        ),

                      ],
                    )
                ),

                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/result');
                  },
                  child: Text('Рассчитать'),
                )
              ],
            ),
          )
      ),
    );
  }

}

class AssertPosition extends StatelessWidget {
  final int index;
  AssertPosition(this.index);

  @override
  Widget build(BuildContext context) {
    var cart = context.read<Cart>();
    Bind bind = cart.binds[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(bind.member.name),
        Text(bind.product.name),
        Text(bind.qty.toString()),
        IconButton(
          onPressed: (){
            context.read<Cart>().removeBind(bind);
          },
          icon: Icon(Icons.cancel),
        ),
      ],
    );
  }

}