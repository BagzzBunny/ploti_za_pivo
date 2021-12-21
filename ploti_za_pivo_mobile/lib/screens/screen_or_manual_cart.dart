import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/main.dart';

class AddCartRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Плати За Пиво'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Сделайте фото чека или введите его позиции вручную'),
              ElevatedButton(
                onPressed: (){

                },
                child: Text('Фото'),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/cart_edit');
                },
                child: Text('Ввести'),
              )
            ],
          ),
        )
    );
  }

}