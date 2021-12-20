import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';
import 'package:ploti_za_pivo_mobile/utils/bill.dart';
import 'package:ploti_za_pivo_mobile/utils/calculator.dart';
import 'package:ploti_za_pivo_mobile/utils/payment_handler.dart';

class Cart extends ChangeNotifier{
  late DateTime date;
  List<Member> members = [];
  List<Product> products = [];
  List<Bind> binds = [];
  Map<String, double> result = {};

  Cart(this.date);

  calculateResult(){
    Bill bill = Bill(products.map((p) => {"name": p.name, "qty": p.qty, "price": p.price}).toList());
    var billData = bill.get_bill_data();
    var data = products.map((p) => {"name": p.name, "participation": getProductBinds(p.name)
        .map((b) => {"name":b.member.name, "amount":b.qty}).toList()}).toList();
    Calculator calc = new Calculator();
    calc.update_debts(data, billData);
    print(calc.get_debts());
    var paymentData = members.where((element) => element.payed).toList().map((m) => m.payed ? {"payer": m.name, "amount": m.amountPayed} : null).toList();
    print(paymentData);
    print('payment:');
    var handledPaymentData = PaymentHandler.handle_payment_data(paymentData);
    calc.send_payment(handledPaymentData);
    print(calc.get_debts());
    result = calc.get_debts();


  }

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

  getMember(String mName){
    return members.firstWhereOrNull((element) => element.name == mName);
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
      sum += bind.product.price;
    }
    return sum;
  }

  addMember(Member member){
    members.add(member);
    notifyListeners();
  }
  removeMember(Member member){
    members.remove(member);
    notifyListeners();
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