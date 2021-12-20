import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/cart.dart';
import 'package:provider/src/provider.dart';

class CartEditRoute extends StatelessWidget {
  String pName = '';
  String pQty = '';
  String pCost = '';
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
                Text('Позиции чека'),
                Container(
                    height: 500,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Позиция'),
                            Text('Количество'),
                            Text('Цена'),
                          ],
                        ),
                        Divider(),
                        Container(
                          height: 400,
                          child: ListView.builder(
                              itemCount: cart.products.length,
                              itemBuilder: (context,index){
                                return CartPosition(index);
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
                                      Form.of(primaryFocus!.context!)!.save();
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints.tight(const Size(200, 50)),
                                            child: TextFormField(
                                              decoration: InputDecoration(hintText: 'Наименование'),
                                              onSaved: (String? value) {
                                                pName = value!;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints.tight(const Size(200, 50)),
                                            child: TextFormField(
                                              decoration: InputDecoration(hintText: 'Количество'),
                                              onSaved: (String? value) {
                                                pQty = value!;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints.tight(const Size(200, 50)),
                                            child: TextFormField(
                                              decoration: InputDecoration(hintText: 'Цена'),
                                              onSaved: (String? value) {
                                                pCost = value!;
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    )

                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    pName = '';
                                    pQty = '';
                                    pCost = '';
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Отмена'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cart.addProduct(Product(pName,int.tryParse(pQty)!,double.tryParse(pCost)!));
                                    pName = '';
                                    pQty = '';
                                    pCost = '';
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
                    Navigator.pushNamed(context, '/cart_assert');
                  },
                  child: Text('Ввести'),
                )
              ],
            ),
          )
      ),
    );
  }

}

class CartPosition extends StatelessWidget {
  final int index;
  CartPosition(this.index);

  @override
  Widget build(BuildContext context) {
    var cart = context.read<Cart>();
    Product product = cart.products[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(product.name),
        Text(product.qty.toString()),
        Text(product.price.toString()),
        IconButton(
          onPressed: (){
            context.read<Cart>().removeProduct(product);
          },
          icon: Icon(Icons.cancel),
        ),
      ],
    );
  }

}