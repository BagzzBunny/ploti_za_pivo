import 'package:flutter/material.dart';

import 'cart.dart';

class HistoryManager extends ChangeNotifier{
  List<Cart> items = [];

  void addCart(Cart cart) {
    items.add(cart);
    notifyListeners();
  }
}