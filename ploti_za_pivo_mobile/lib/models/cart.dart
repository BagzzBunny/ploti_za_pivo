import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:ploti_za_pivo_mobile/models/member.dart';

class Cart extends ChangeNotifier{
  late DateTime date;
  List<Member> members = [];
  List<Product> products = [];
  List<Bind> binds = [];

  Cart(this.date);

  double getCostSum(){
    double res = 0;
    for (Product p in products){
      res += p.qty * p.price;
    }
    return res;
  }

  getProduct(String pName){
    return products.firstWhereOrNull((element) => element.name == pName);
  }

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

  addProduct(Product product){
    products.add(product);
    notifyListeners();
  }
  removeProduct(Product product){
    products.remove(product);
    notifyListeners();
  }

  addBind(Bind bind){
    binds.add(bind);
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