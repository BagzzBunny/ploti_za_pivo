import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';
import 'package:ploti_za_pivo_mobile/utils/bill.dart';
import 'package:ploti_za_pivo_mobile/utils/calculator.dart';
import 'package:ploti_za_pivo_mobile/utils/event_handler.dart';
import 'package:ploti_za_pivo_mobile/utils/payment_handler.dart';

class Event extends ChangeNotifier{
  UniqueKey id = UniqueKey();
  late DateTime date;
  late String name;
  List<Member> members = [];
  Map<String, double> result = {};
  Event(this.date,this.name);

  setName(String newName){
    name = newName;
    notifyListeners();
  }
  getCostSum(){}

  getMember(String mName){
    return members.firstWhereOrNull((element) => element.name == mName);
  }
  addMember(Member member){
    members.add(member);
    notifyListeners();
  }
  removeMember(Member member){
    members.remove(member);
    notifyListeners();
  }

  @override
  bool operator ==(Object other) => other is Event && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

class EventSequence extends Event{
  late DateTime endDate;
  List<Cart> carts = [];

  EventSequence(DateTime date,String name) : super(date,name);
  
  addCart(Cart cart){
    carts.add(cart);
    endDate = (carts.map((e) => e.date).toList()).max;
    for (Member member in cart.members){
      if (!members.contains(member)){
        members.add(member);
      }
    }
    notifyListeners();
  }
  
  removeCart(Cart cart){
    carts.remove(cart);
    endDate = (carts.map((e) => e.date).toList()).max;
    notifyListeners();
  }

  @override
  getCostSum(){
    return (carts.map((e) => e.getCostSum()).toList()).sum;
  }

  setEventSequence(EventSequence event){
    id = event.id;
    date = event.date;
    name = event.name;
    endDate = event.endDate;
    carts = List<Cart>.from(event.carts);
    members = List<Member>.from(event.members);
    result = Map<String, double>.from(event.result);
  }

  copyEventSequence(EventSequence event){
    id = UniqueKey();
    date = event.date;
    name = event.name;
    endDate = event.endDate;
    carts = List<Cart>.from(event.carts);
    members = List<Member>.from(event.members);
    result = Map<String, double>.from(event.result);
  }
  
  clearEventSequence(){
    id = UniqueKey();
    date = DateTime.now();
    name = '';
    endDate = DateTime.now();
    carts = [];
    members = [];
    result = <String, double>{};
  }
  
  calculateResult(){
    EventHandler event = EventHandler();
    event.initialize_event(
        name,
        date.day.toString() + '-' + date.month.toString() + '-' + date.year.toString(),
        members.map((e) => e.name).toList());
    for (Cart cart in carts){
      cart.calculateResult();
      event.add_purchase(cart.name, cart.result);
    }
    event.calculate_overall_debts();

    result = event.get_overall_debts();
    print(name);
    print(result);
    print(event.get_overall_transacions());
  }
  calculateTransactions(){
    EventHandler event = EventHandler();
    event.initialize_event(
        name,
        date.day.toString() + '-' + date.month.toString() + '-' + date.year.toString(),
        members.map((e) => e.name).toList());
    for (Cart cart in carts){
      cart.calculateResult();
      event.add_purchase(cart.name, cart.result);
    }
    event.calculate_overall_debts();


    return event.get_overall_transacions();
  }
}

class Cart extends Event{
  
  
  List<Product> products = [];
  List<Bind> binds = [];
  

  Cart(DateTime date,String name) : super(date,name);

  setCart(Cart cart){
    id = cart.id;
    date = cart.date;
    name = cart.name;
    members = List<Member>.from(cart.members);
    products = List<Product>.from(cart.products);
    binds = List<Bind>.from(cart.binds);
    result = Map<String, double>.from(cart.result);
  }

  copyCart(Cart cart){
    id = UniqueKey();
    date = cart.date;
    name = cart.name;
    members = List<Member>.from(cart.members);
    products = List<Product>.from(cart.products);
    binds = List<Bind>.from(cart.binds);
    result = Map<String, double>.from(cart.result);
  }

  clearCart(){
    id = UniqueKey();
    date = DateTime.now();
    name = '';
    members = [];
    products =[];
    binds = [];
    result =  <String, double>{};
  }

  calculateResult(){
    Bill bill = Bill(products.map((p) => {"name": p.name, "qty": p.qty, "price": p.price}).toList());
    var billData = bill.get_bill_data();
    var data = products.map((p) => {"name": p.name, "participation": getProductBinds(p.name)
        .map((b) => {"name":b.member.name, "amount":b.qty}).toList()}).toList();
    Calculator calc = Calculator();
    calc.update_debts(data, billData);
    var paymentData = members.where((element) => element.payed).toList().map((m) => m.payed ? {"payer": m.name, "amount": m.amountPayed} : null).toList();
    var handledPaymentData = PaymentHandler.handle_payment_data(paymentData);
    calc.send_payment(handledPaymentData);
    result = calc.get_debts();
    print(name);
    print(result);
    print(calc.calculate_transactions());
  }

  calculateTransactions(){
    Bill bill = Bill(products.map((p) => {"name": p.name, "qty": p.qty, "price": p.price}).toList());
    var billData = bill.get_bill_data();
    var data = products.map((p) => {"name": p.name, "participation": getProductBinds(p.name)
        .map((b) => {"name":b.member.name, "amount":b.qty}).toList()}).toList();
    Calculator calc = Calculator();
    calc.update_debts(data, billData);
    var paymentData = members.where((element) => element.payed).toList().map((m) => m.payed ? {"payer": m.name, "amount": m.amountPayed} : null).toList();
    var handledPaymentData = PaymentHandler.handle_payment_data(paymentData);
    calc.send_payment(handledPaymentData);
    calc.get_debts();
    return calc.calculate_transactions();
  }

  @override
  double getCostSum(){
    double res = 0;
    for (Product p in products){
      res += p.price;
    }
    return res;
  }

  getProduct(String pName){
    return products.firstWhereOrNull((element) => element.name == pName);
  }
  
  List<Bind> getProductBinds(String pName){
    Product? target = products.firstWhereOrNull((element) => element.name == pName);
    return binds.where((element) => element.product == target).toList();
  }

  getMemberBinds(String mName){
    Member? target = members.firstWhereOrNull((element) => element.name == mName);
    return binds.where((element) => element.member == target).toList();
  }

  getMemberBindsSum(String mName){
    Member? target = members.firstWhereOrNull((element) => element.name == mName);
    var b = binds.where((element) => element.member == target).toList();

    double sum = 0;

    for (var bind in b){
      int prts = 0;
      for (var pbind in binds.where((element) => element.product == bind.product).toList()){
        prts+=pbind.qty;
      }
      sum += bind.product.price * bind.qty / prts;
    }
    return sum;
  }
  
  addProduct(Product product){
    if (products.contains(product)) {
      products.firstWhere((p) => p.name == product.name).qty+=product.qty;
    }
    else{
      products.add(product);
    }
    notifyListeners();
  }
  removeProduct(Product product){
    products.remove(product);
    notifyListeners();
  }

  addBind(Bind bind){
    if (binds.contains(bind)){
      binds.firstWhere((b) => b.member == bind.member && b.product == bind.product).qty += bind.qty;
    }
    else {
      binds.add(bind);
    }
    notifyListeners();
  }
  removeBind(Bind bind){
    binds.remove(bind);
    notifyListeners();
  }
}

class Product{
  late String name;
  late int qty;
  late double price;

  Product(this.name, this.qty, this.price);

  @override
  bool operator ==(Object other) => other is Product && other.name == name;

  @override
  int get hashCode => name.hashCode;
}

class Bind{
  late Member member;
  late Product product;
  late int qty;

  Bind(this.member,this.product,this.qty);

  @override
  bool operator ==(Object other) => other is Bind && other.member == member && other.product == product;

  @override
  int get hashCode => (member.name+product.name).hashCode;
}