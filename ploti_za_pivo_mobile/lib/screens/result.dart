import 'package:flutter/material.dart';

class ResultRoute extends StatelessWidget {
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
                Text('Проверьте результаты'),
                Container(
                    height: 600,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Имя'),
                            Text('Позиция'),
                          ],
                        ),
                        Divider(),
                        Container(
                          height: 500,
                          child: ListView.builder(
                              itemCount: 3,
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
                    Navigator.pushNamed(context, '/transactions');
                  },
                  child: Text('Далее'),
                )
              ],
            ),
          )
      ),
    );
  }

}

class MemberSumUp extends StatelessWidget {
  final int index;
  MemberSumUp(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Имя' + index.toString()),
        Container(
          height: 100,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context,innerindex) {
              return Text('Позиция и количество ' + innerindex.toString());
            },
          ),
        ),

        Divider(),
        Text('Итого: итоговый счет ' + index.toString()),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

}