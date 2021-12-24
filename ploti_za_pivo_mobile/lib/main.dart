
import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/history_manager.dart';
import 'package:ploti_za_pivo_mobile/screens/add_cart_from_history.dart';
import 'package:ploti_za_pivo_mobile/screens/add_travel_members.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_history.dart';
import 'package:ploti_za_pivo_mobile/screens/travel_add_cart.dart';
import 'package:ploti_za_pivo_mobile/screens/travel_history.dart';
import 'package:ploti_za_pivo_mobile/screens/travel_result.dart';
import 'package:provider/provider.dart';
import 'package:ploti_za_pivo_mobile/screens/add_members.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_assert.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_edit.dart';
import 'package:ploti_za_pivo_mobile/screens/history.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_result.dart';
import 'package:ploti_za_pivo_mobile/screens/screen_or_manual_cart.dart';
import 'package:ploti_za_pivo_mobile/screens/cart_transactions.dart';
import 'package:ploti_za_pivo_mobile/screens/welcome.dart';

import 'models/bind_info.dart';
import 'models/event.dart';


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
        ChangeNotifierProvider(create: (context) => Cart(DateTime.now(),'')),
        ChangeNotifierProvider(create: (context) => EventSequence(DateTime.now(),'')),
        ChangeNotifierProvider(create: (context) => BindInfo()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          routes:{
            '/' : (context) => WelcomeRoute(),
            '/add_members' : (context) => AddMembersRoute(),
            '/add_cart_from_history' : (context) => AddCartFromHistoryRoute(),
            '/add_travel_members' : (context) => AddTravelMembersRoute(),
            '/cart_assert' : (context) => CartAssertRoute(),
            '/cart_edit' : (context) => CartEditRoute(),
            '/cart_history' : (context) => CartHistoryRoute(),
            '/cart_result' : (context) => ResultRoute(),
            '/cart_transactions' : (context) => TransactionsRoute(),
            '/history' : (context) => HistoryRoute(),
            '/screen_or_manual_cart' : (context) => AddCartRoute(),
            '/travel_add_cart' : (context) => TravelAddCartRoute(),
            '/travel_history' : (context) => TravelHistoryRoute(),
            '/travel_result' : (context) => TravelResultRoute(),

          }
      )
    );

  }
}

