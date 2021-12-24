import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/event.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/src/provider.dart';

import 'item_builders/event_builder.dart';

class HistoryRoute extends StatelessWidget {
  String eventName = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var history = context.watch<HistoryManager>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Плати За Пиво'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('История'),
              Container(
                height: 500,
                child: Column(
                  children: [
                    BuildItemLabel(),
                    Divider(),
                    Container(
                      height: 400,
                      child: ListView.builder(
                        itemCount: history.items.length,
                        itemBuilder: (context,index) => BuildHistoryItem(index),
                      ),
                    ),

                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Новый счет'),
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
                                  hintText: 'Название события',
                                  labelText:'Название',

                                ),

                                onSaved: (String? value) {
                                  eventName = value!;
                                },
                                validator: (String? value) {
                                  return (value != null && value.isEmpty ) ? 'Введите название' : null;
                                },
                              ),
                            ),
                          )
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          eventName ='';
                          Navigator.pop(context);
                        },
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            var cart = context.read<Cart>();
                            cart.clearCart();
                            cart.setName(eventName);
                            eventName ='';
                            history.editingSequence = false;
                            Navigator.pushNamed(context, '/add_members');
                          }
                        },
                        child: const Text('Добавить'),
                      ),
                    ],
                  ),
                ),
                child: Text('Добавить счет'),
              ),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Новое путешествие'),
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
                                  hintText: 'Название события',
                                  labelText:'Название',

                                ),

                                onSaved: (String? value) {
                                  eventName = value!;
                                },
                                validator: (String? value) {
                                  return (value != null && value.isEmpty ) ? 'Введите название' : null;
                                },
                              ),
                            ),
                          )
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          eventName ='';
                          Navigator.pop(context);
                        },
                        child: const Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            var sequence = context.read<EventSequence>();
                            sequence.clearEventSequence();
                            sequence.setName(eventName);
                            eventName ='';
                            history.editingSequence = true;
                            Navigator.pushNamed(context, '/add_travel_members');
                          }
                        },
                        child: const Text('Добавить'),
                      ),
                    ],
                  ),
                ),
                child: Text('Добавить путешествие'),
              )
            ],
          ),
        )
    );
  }

}

