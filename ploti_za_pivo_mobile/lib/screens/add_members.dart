import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ploti_za_pivo_mobile/app_bar_builder.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';
import 'package:provider/provider.dart';

class AddMembersRoute extends StatelessWidget {
  String newMember = "";
  final _formKey = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> _memberFormKeys = [];


  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    for (var member in cart.members){
      _memberFormKeys.add(GlobalKey<FormState>());
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Плати За Пиво'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Пожалуйста, добавьте участников покупки'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 150,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Имя',style: TextStyle(fontSize: 20),),
                      )
                  ),

                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Платил?',style: TextStyle(fontSize: 20),),
                        )
                      ),

                      Container(
                        width: 70,
                        height: 50,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Удалить',style: TextStyle(fontSize: 15),),
                        )
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: cart.members.length,
                    itemBuilder: (context,index) {
                      return BuildMember(index,_memberFormKeys);
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
                      title: const Text('Новый участник'),
                      content: FocusTraversalGroup(
                        child: Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: _formKey,
                            onChanged: () {
                              Form.of(primaryFocus!.context!)!.save();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints.tight(const Size(200, 50)),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Имя участника',
                                    labelText:'Имя',

                                  ),

                                  onSaved: (String? value) {
                                    newMember = value!;
                                  },
                                  validator: (String? value) {
                                    return (value != null && value.isEmpty ) ? 'Введите имя' : null;
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
                            if(_formKey.currentState!.validate()){
                              cart.addMember(Member(newMember,false,0));
                              if(_memberFormKeys.length < cart.members.length)
                              {
                                _memberFormKeys.add(GlobalKey<FormState>());
                              }

                              newMember ='';
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 58, 97, 87), // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                  ),

                  onPressed: (){
                    if (cart.members.isEmpty) return;
                    for (Member member in cart.members){
                      if (member.payed && !_memberFormKeys[cart.members.indexOf(member)].currentState!.validate()) return;
                    }
                    Navigator.pushNamed(context, '/screen_or_manual_cart');
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

class BuildMember extends StatefulWidget {
  final int index;
  final List<GlobalKey<FormState>> memberFormKeys;
  BuildMember(this.index, this.memberFormKeys);
  @override
  State<StatefulWidget> createState() => _BuildMemberState(this.index,this.memberFormKeys);

}

class _BuildMemberState extends State<BuildMember> {
  final int index;
  final List<GlobalKey<FormState>> memberFormKeys;
  _BuildMemberState(this.index, this.memberFormKeys);

  @override
  Widget build(BuildContext context) {
    var cart = context.read<Cart>();
    Member member = cart.members[index];
    return Column(
      children: member.payed ? [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 150,
              height: 50,
              color: Color.fromARGB(255, 215, 255, 215),
              margin: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.center,
                child: Text(member.name,style: TextStyle(fontSize: 20),),
              )
            ),

            Row(
              children: [
                Container(
                  width: 100,
                  height: 50,
                  child: Checkbox(
                    value: member.payed,
                    onChanged: (val) {
                      setState(() {
                        member.payed = val!;
                      });
                    },
                  ),
                ),

                IconButton(
                  onPressed: (){
                    context.read<Cart>().removeMember(member);
                  },
                  icon: Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),
        Center(
          child: Container(
            width: 180,
            child:Form(
              key:memberFormKeys[index],
              child: TextFormField(

                decoration: InputDecoration(
                  hintText: 'Сумма, которую заплатил',
                  labelText:'Сумма',

                ),
                onChanged: (val){
                  member.amountPayed = double.tryParse(val)!;
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
          ),
        )




      ] : [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 150,
                height: 50,
                color: Color.fromARGB(255, 215, 255, 215),
                margin: EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(member.name,style: TextStyle(fontSize: 20),),
                )
            ),

            Row(
              children: [
                Container(
                  width: 100,
                  height: 50,
                  child: Checkbox(
                    value: member.payed,
                    onChanged: (val) {
                      setState(() {
                        member.payed = val!;
                      });
                    },
                  ),
                ),

                IconButton(
                  onPressed: (){
                    context.read<Cart>().removeMember(member);
                  },
                  icon: Icon(Icons.cancel),
                ),
              ],
            )
          ],
        ),

      ],
    );
  }

}