import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ploti_za_pivo_mobile/app_bar_builder.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';
import 'package:provider/provider.dart';

class AddTravelMembersRoute extends StatelessWidget {
  String newMember = "";
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var sequence = context.watch<EventSequence>();

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
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: sequence.members.length,
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
                            sequence.addMember(Member(newMember,false,0));

                            newMember ='';
                            Navigator.pop(context);
                          }
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
                  context.read<HistoryManager>().addEvent(sequence);
                  Navigator.pushNamed(context, '/travel_history');
                },
                child: Text('Далее'),
              )
            ],
          ),
        )
    );
  }
}

class BuildMember extends StatelessWidget {
  final int index;
  BuildMember(this.index);

  @override
  Widget build(BuildContext context) {
    var sequence = context.read<EventSequence>();
    Member member = sequence.members[index];
    return Container(
      height: 60,
      child: Text(member.name),
    );
  }

}