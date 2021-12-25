import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ploti_za_pivo_mobile/models/bind_info.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
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
  String pQty = '';

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
              Text('Сопоставьте участников покупок и позиции чека'),
              Container(
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: 100,
                              height: 50,
                              margin: EdgeInsets.all(5),
                              child:Align(
                                alignment: Alignment.center,
                                child: Text('Имя',style: TextStyle(fontSize: 18),),
                              )
                          ),
                          Container(
                              width: 100,
                              height: 50,
                              margin: EdgeInsets.all(5),
                              child:Align(
                                alignment: Alignment.center,
                                child: Text('Позиция',style: TextStyle(fontSize: 18),),
                              )
                          ),
                          Container(
                              width: 60,
                              height: 50,
                              margin: EdgeInsets.all(5),
                              child:Align(
                                alignment: Alignment.center,
                                child: Text('Кол-во',style: TextStyle(fontSize: 18),),
                              )
                          ),
                          SizedBox(width: 50,)
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
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Количество частей',
                                            labelText: 'Части',
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
                                        /*DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Позиция',
                                          ),
                                          value: context.watch<BindInfo>().selected == 0 ? null : context.watch<BindInfo>().selected.toString(),
                                          onChanged: (String? value) {
                                            context.read<BindInfo>().selected = int.tryParse(value!)!;
                                          },
                                          items: context.watch<BindInfo>().items,
                                        ),*/
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
                    Navigator.pushNamed(context, '/cart_result');
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
        Container(
            width: 100,
            height: 50,
            margin: EdgeInsets.all(5),
            color: Color.fromARGB(255, 215, 255, 215) ,
            child:Align(
              alignment: Alignment.center,
              child: Text(bind.member.name,style: TextStyle(fontSize: 18),),
            )
        ),
        Container(
            width: 100,
            height: 50,
            margin: EdgeInsets.all(5),
            color: Color.fromARGB(255, 215, 255, 215) ,
            child:Align(
              alignment: Alignment.center,
              child: Text(bind.product.name,style: TextStyle(fontSize: 18),),
            )
        ),
        Container(
            width: 60,
            height: 50,
            margin: EdgeInsets.all(5),
            color: Color.fromARGB(255, 215, 255, 215) ,
            child:Align(
              alignment: Alignment.center,
              child: Text(bind.qty.toString(),style: TextStyle(fontSize: 18),),
            )
        ),
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