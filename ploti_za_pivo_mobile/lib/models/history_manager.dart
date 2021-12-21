import 'package:flutter/material.dart';

import 'cart.dart';
import 'member.dart';

class HistoryManager extends ChangeNotifier{
  List<Cart> items = [];
  
  HistoryManager(){
    var cart = Cart(DateTime.now());
    cart.addMember(Member('Вася',true,130));
    cart.addMember(Member('Маша',true,10));
    cart.addMember(Member('Петя',false,0));
    cart.addProduct(Product('A',5,100));
    cart.addProduct(Product('B',1,30));
    cart.addProduct(Product('C',1,10));
    cart.addBind(Bind(cart.getMember('Вася'),cart.getProduct('A'),5));
    cart.addBind(Bind(cart.getMember('Петя'),cart.getProduct('A'),5));
    cart.addBind(Bind(cart.getMember('Маша'),cart.getProduct('B'),1));
    cart.addBind(Bind(cart.getMember('Вася'),cart.getProduct('C'),1));
    cart.addBind(Bind(cart.getMember('Петя'),cart.getProduct('C'),1));
    cart.calculateResult();
    items.add(cart);
  }

  void addCart(Cart cart) {
    if (!items.contains(cart)){
      items.add(cart);
    }

    notifyListeners();
  }


}