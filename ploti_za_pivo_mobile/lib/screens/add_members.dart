import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/app_bar_builder.dart';

class AddMembersRoute extends StatelessWidget {
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
                Text('Пожалуйста, добавьте участников покупки'),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context,index) {
                      return Member(index);
                    }
                  ),
                ),
                ElevatedButton(
                  onPressed: (){

                  },
                  child: Text('Добавить'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/screen_or_manual_cart');
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

class Member extends StatefulWidget {
  final int index;
  Member(this.index);
  @override
  State<StatefulWidget> createState() => _MemberState(this.index);

}

class _MemberState extends State<Member> {
  final int index;
  bool payed = false;
  _MemberState(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: payed ? [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Имя' + index.toString()),
            Checkbox(
              value: payed,
              onChanged: (val) {
                setState(() {
                  payed = val!;
                });
              },
            ),
          ],
        ),

        TextFormField(
          initialValue: 'Сумма, которую заплатил',
        )
      ] : [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Имя' + index.toString()),
            Checkbox(
              value: payed,
              onChanged: (val) {
                setState(() {
                  payed = val!;
                });
              },
            ),
          ],
        ),

      ],
    );
  }

}