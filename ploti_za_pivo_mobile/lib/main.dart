
import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/screens/add_members.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_assert.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_edit.dart';
import 'package:ploti_za_pivo_mobile/screens/history.dart';
import 'package:ploti_za_pivo_mobile/screens/result.dart';
import 'package:ploti_za_pivo_mobile/screens/screen_or_manual_cart.dart';
import 'package:ploti_za_pivo_mobile/screens/transactions.dart';
import 'package:ploti_za_pivo_mobile/screens/welcome.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes:{
        '/' : (context) => WelcomeRoute(),
        '/history' : (context) => HistoryRoute(),
        '/add_members' : (context) => AddMembersRoute(),
        '/screen_or_manual_cart' : (context) => AddCartRoute(),
        '/cart_edit' : (context) => CartEditRoute(),
        '/cart_assert' : (context) => CartAssertRoute(),
        '/result' : (context) => ResultRoute(),
        '/transactions' : (context) => TransactionsRoute(),
      }
    );
  }
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  'Добро пожаловать в',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  )
              ),
              Text(
                  'Плати за пиво',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                  )
              ),
              Image.asset('lib/assets/mainlogo.png',scale:0.5),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/persons');
                  },
                  child: Container(
                    child: Text(
                      'Начать',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  )
              )
            ]
        ),
      )

    );
  }
}

class PersonsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Пожалуйста добавьте участников покупки',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                )
            ),
            ElevatedButton(
                onPressed: () {},
                child: Container(
                  child: Text(
                    'Добавить',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                )
            ),
            Container(
              height: 500,
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Борис'),
                  ),
                  ListTile(
                    title: Text('Дмитрий'),
                  )
                ],
              ),
            )
            ,
            SizedBox(height: 200,),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                child: Container(
                  child: Text(
                    'Далее',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                )
            )
          ]
      ),
    );
  }
}

class CartRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Пожалуйста добавьте покупки',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                )
            ),
            ElevatedButton(
                onPressed: () {},
                child: Container(
                  child: Text(
                    'Добавить',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                )
            ),
            Container(
              height: 500,
              child:ListView(
                children: [
                  ListTile(
                    title: Text('Пиво'),
                    trailing: Text('цена'),
                  ),
                  ListTile(
                    title: Text('гренки'),
                    trailing: Text('цена'),
                  )
                ],
              ),
            ),

            SizedBox(height: 200,),
            ElevatedButton(
                onPressed: () {},
                child: Container(
                  child: Text(
                    'Далее',
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                )
            )
          ]
      ),
    );
  }
}
