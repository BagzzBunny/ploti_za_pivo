import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:provider/src/provider.dart';

class CartEditRoute extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String pName = '';
  String pQty = '';
  String pCost = '';
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return Scaffold(
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
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 150,
                          height: 50,
                          margin: EdgeInsets.all(5),
                          color: Color.fromARGB(255, 215, 255, 215) ,
                          child:Align(
                            alignment: Alignment.center,
                            child: Text('Наименование',style: TextStyle(fontSize: 18),),
                          )
                      ),
                      Container(
                          width: 60,
                          height: 50,
                          margin: EdgeInsets.all(5),
                          color: Color.fromARGB(255, 215, 255, 215) ,
                          child:Align(
                            alignment: Alignment.center,
                            child: Text('Кол-во',style: TextStyle(fontSize: 18),),
                          )
                      ),
                      Container(
                          width: 80,
                          height: 50,
                          margin: EdgeInsets.all(5),
                          color: Color.fromARGB(255, 215, 255, 215) ,
                          child:Align(
                            alignment: Alignment.center,
                            child: Text('Цена',style: TextStyle(fontSize: 18),),
                          )
                      ),

                      SizedBox(width: 50,)
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
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 58, 97, 87), // background
                              onPrimary: Colors.white, // foreground
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )
                          ),

                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Новая позиция чека'),
                              content: FocusTraversalGroup(
                                child: Form(
                                    key: _formKey,
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
                                              decoration: InputDecoration(
                                                  hintText: 'Наименование позиции',
                                                  labelText: 'Наименование'
                                              ),
                                              onSaved: (String? value) {
                                                pName = value!;
                                              },
                                              validator: (String? value) {
                                                return (value != null && value.isEmpty ) ? 'Введите наименование' : null;
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints.tight(const Size(200, 50)),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                hintText: 'Количество в чеке',
                                                labelText: 'Количество',
                                              ),
                                              onSaved: (String? value) {
                                                pQty = value!;
                                              },
                                              validator: (String? value) {
                                                return (value != null && (value.isEmpty || int.tryParse(value) == 0)) ? 'Введите количество' : null;
                                              },
                                              keyboardType:TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'(^\d*)'))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints.tight(const Size(200, 50)),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: 'Итоговая цена в чеке',
                                                  labelText: 'Цена'
                                              ),
                                              onSaved: (String? value) {
                                                pCost = value!;
                                              },
                                              validator: (String? value) {
                                                return (value != null && (value.isEmpty || double.tryParse(value) == 0)) ? 'Введите сумму' : null;
                                              },
                                              keyboardType:TextInputType.numberWithOptions(decimal: true),
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d?\d?)'))
                                              ],
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
                                    if(_formKey.currentState!.validate()){
                                      cart.addProduct(Product(pName,int.tryParse(pQty)!,double.tryParse(pCost)!));
                                      pName = '';
                                      pQty = '';
                                      pCost = '';
                                      Navigator.pop(context);
                                    }

                                  },
                                  child: const Text('Добавить'),
                                ),
                              ],
                            ),
                          ),
                          child: Container(
                              width: 250,
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Добавить',style: TextStyle(fontSize: 30),),
                              )
                          )
                      ),

                    ],
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
                    if (cart.products.length==0) return;
                    Navigator.pushNamed(context, '/cart_assert');
                  },
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Далее',style: TextStyle(fontSize: 30),),
                      )
                  )
              ),

            ],
          ),
        )
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
        Container(
          width: 150,
          height: 50,
          margin: EdgeInsets.all(5),
          color: Color.fromARGB(255, 215, 255, 215) ,
          child:Align(
            alignment: Alignment.center,
            child: Text(product.name,style: TextStyle(fontSize: 18),),
          )
        ),
        Container(
          width: 60,
          height: 50,
          margin: EdgeInsets.all(5),
            color: Color.fromARGB(255, 215, 255, 215) ,
          child:Align(
            alignment: Alignment.center,
            child: Text(product.qty.toString(),style: TextStyle(fontSize: 18),),
          )
        ),
        Container(
          width: 80,
          height: 50,
          margin: EdgeInsets.all(5),
            color: Color.fromARGB(255, 215, 255, 215) ,
          child:Align(
            alignment: Alignment.center,
            child: Text(product.price.toString(),style: TextStyle(fontSize: 18),),
          )
        ),

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