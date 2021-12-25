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
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 58, 97, 87), // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      )
                  ),

                  onPressed: null,
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Фото',style: TextStyle(fontSize: 30),),
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
                    Navigator.pushNamed(context, '/cart_edit');
                  },
                  child: Container(
                      width: 250,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Ввести вручную',style: TextStyle(fontSize: 30),),
                      )
                  )
              ),
            ],
          ),
        )
    );
  }

}