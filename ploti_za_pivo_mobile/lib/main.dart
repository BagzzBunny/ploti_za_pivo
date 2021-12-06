
import 'package:flutter/material.dart';


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
        '/' : (context) => HomeRoute(),
      }
    );
  }
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Добро пожаловать в',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            )
          ),
          Text(
              'Плати за пиво',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              )
          ),
          Image.asset('mainlogo.png'),
          ElevatedButton(
              onPressed: () {},
              child: Container(
                child: Text(
                  'Начать',
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
            ListView(
              children: [
                ListTile(
                  title: Text('Борис'),
                ),
                ListTile(
                  title: Text('Дмитрий'),
                )
              ],
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

class BuysRoute extends StatelessWidget {
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
            ListView(
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
