import 'package:flutter/material.dart';


class BindInfo extends ChangeNotifier{
  List<DropdownMenuItem<String>> items = [];
  int selected = 0;

  updateItems(int val){
    items = List<int>.generate(val,(i) =>i+1)
        .map((int qty) {
      return DropdownMenuItem<String>(
        value: qty.toString(),
        child: Text(qty.toString()),
      );
    }).toList();
    selected = val;
    notifyListeners();
  }
}