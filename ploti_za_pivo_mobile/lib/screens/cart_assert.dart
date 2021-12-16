import 'package:flutter/material.dart';

class CartAssertRoute extends StatelessWidget {
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
                              itemCount: 3,
                              itemBuilder: (context,index){
                                return AssertPosition(index);
                              }
                          ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Имя' + index.toString()),
        Text('Позиция' + index.toString()),
      ],
    );
  }

}