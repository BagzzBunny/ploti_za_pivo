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
                    context.read<HistoryManager>().addEvent(sequence);
                    Navigator.pushNamed(context, '/travel_history');
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

class BuildMember extends StatelessWidget {
  final int index;
  BuildMember(this.index);

  @override
  Widget build(BuildContext context) {
    var sequence = context.read<EventSequence>();
    Member member = sequence.members[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            width: 250,
            height: 50,
            color: Color.fromARGB(255, 215, 255, 215),
            margin: EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.center,
              child: Text(member.name,style: TextStyle(fontSize: 20),),
            )
        ),
        IconButton(
          onPressed: (){
            context.read<Cart>().removeMember(member);
          },
          icon: Icon(Icons.cancel),
        ),
      ],
    );
  }

}