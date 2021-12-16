import 'package:flutter/material.dart';

class CartEditRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                              itemCount: 3,
                              itemBuilder: (context,index){
                                return CartPosition(index);
                              }
                          ),
                        ),

                        ElevatedButton(
                          onPressed: (){

                          },
                          child: Text('Добавить'),
                        )

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
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Позиция' + index.toString()),
        Text('Количество' + index.toString()),
        Text('Цена' + index.toString()),
      ],
    );
  }

}