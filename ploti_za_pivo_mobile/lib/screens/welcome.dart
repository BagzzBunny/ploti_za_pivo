

import 'package:flutter/material.dart';

class WelcomeRoute extends StatelessWidget {
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
                      Navigator.pushNamed(context, '/history');
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