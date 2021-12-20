
import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:provider/provider.dart';
import 'package:ploti_za_pivo_mobile/screens/add_members.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_assert.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_edit.dart';
import 'package:ploti_za_pivo_mobile/screens/history.dart';
import 'package:ploti_za_pivo_mobile/screens/result.dart';
import 'package:ploti_za_pivo_mobile/screens/screen_or_manual_cart.dart';
import 'package:ploti_za_pivo_mobile/screens/transactions.dart';
import 'package:ploti_za_pivo_mobile/screens/welcome.dart';

import 'models/bind_info.dart';
import 'models/cart.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HistoryManager()),
        ChangeNotifierProvider(create: (context) => Cart(DateTime.now())),
        ChangeNotifierProvider(create: (cintext) => BindInfo()),
      ],
      child: MaterialApp(
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
      )
    );

  }
}

