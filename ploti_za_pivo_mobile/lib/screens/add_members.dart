import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/app_bar_builder.dart';
import 'package:ploti_za_pivo_mobile/models/cart.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';
import 'package:provider/src/provider.dart';

class AddMembersRoute extends StatelessWidget {
  String newMember = "";


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
                Text('Пожалуйста, добавьте участников покупки'),
                Container(
                  height: 500,
                  child: ListView.builder(
                    itemCount: cart.members.length,
                    itemBuilder: (context,index) {
                      return BuildMember(index);
                    }
                  ),
                ),
                ElevatedButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Новый участник'),
                      content: FocusTraversalGroup(
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          onChanged: () {
                            Form.of(primaryFocus!.context!)!.save();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tight(const Size(200, 50)),
                              child: TextFormField(
                                onSaved: (String? value) {
                                  newMember = value!;
                                },
                              ),
                            ),
                          )
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            newMember ='';
                            Navigator.pop(context);
                          },
                          child: const Text('Отмена'),
                        ),
                        TextButton(
                          onPressed: () {
                            cart.addMember(Member(newMember,false,0));
                            newMember ='';
                            Navigator.pop(context);
                          },
                          child: const Text('Добавить'),
                        ),
                      ],
                    ),
                  ),
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

class BuildMember extends StatefulWidget {
  final int index;
  BuildMember(this.index);
  @override
  State<StatefulWidget> createState() => _BuildMemberState(this.index);

}

class _BuildMemberState extends State<BuildMember> {
  final int index;
  _BuildMemberState(this.index);

  @override
  Widget build(BuildContext context) {
    var cart = context.read<Cart>();
    Member member = cart.members[index];
    return Column(

      children: member.payed ? [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(member.name),
            Checkbox(
              value: member.payed,
              onChanged: (val) {
                setState(() {
                  member.payed = val!;
                });
              },
            ),
            IconButton(
              onPressed: (){
                context.read<Cart>().removeMember(member);
              },
              icon: Icon(Icons.cancel),
            ),
          ],
        ),

        TextFormField(
          decoration: InputDecoration(
            hintText: 'Сумма, которую заплатил',
          ),
          onChanged: (val){
            member.amountPayed = double.tryParse(val)!;
          },
        ),

      ] : [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(member.name),
            Checkbox(
              value: member.payed,
              onChanged: (val) {
                setState(() {
                  member.payed = val!;
                });
              },
            ),
            IconButton(
              onPressed: (){
                context.read<Cart>().removeMember(member);
              },
              icon: Icon(Icons.cancel),
            )
          ],
        ),

      ],
    );
  }

}