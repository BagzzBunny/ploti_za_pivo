

import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/src/provider.dart';

class WelcomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: context.read<HistoryManager>().initHistory(),
          builder: (context,snapshot) {
            if (snapshot.hasData){
              print('snapshot has data');
              return Center(
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
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 58, 97, 87), // background
                            onPrimary: Colors.white, // foreground
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                              )
                          ),

                          onPressed: (){

                            Navigator.pushNamed(context, '/history');
                          },
                          child: Container(
                            width: 250,
                            height: 50,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Начать',style: TextStyle(fontSize: 30),),
                            )
                          )
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 58, 97, 87), // background
                              onPrimary: Colors.white, // foreground
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              )
                          ),

                          onPressed: (){
                            context.read<HistoryManager>().makeExamples();
                            Navigator.pushNamed(context, '/history');
                          },
                          child: Container(
                              width: 250,
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text('Примеры',style: TextStyle(fontSize: 30),),
                              )
                          )
                      ),

                    ],
                ),
              );
            }
            return Center(
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
                      CircularProgressIndicator(),
                    ]
                ),
              );

          },
        )

    );
  }
}