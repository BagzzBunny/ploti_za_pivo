import 'bill.dart';

class Calculator {
  var debts = new Map<String, double>();

  get_debts() {
    return debts;
  }

  clear_debts() {
    debts = {};
  }

  void update_debts(data, var billData) {
    Bill bill = new Bill(billData);
    for (var product in data) {
      String name = product["name"];
      double price = bill.get_product_price(name);
      dynamic parts = 0;
      for (var person in product["participation"]) {//person was key
        parts = parts + person["amount"];
      }
      for (var person in product["participation"]) {
        if (debts.containsKey(person["name"])) {
          debts[person["name"]] =
              debts[person["name"]]! + person["amount"] / parts * price;
        } else {
          debts[person["name"]] = person["amount"] / parts * price;
        }
      }
    }
  }

  void send_payment(payment_data) {
    for (var person in payment_data.keys) {
      if (debts.containsKey(person)) {
        debts[person] = debts[person]! + payment_data[person];
      } else {
        debts[person] = payment_data[person];
      }
    }
  }
}
