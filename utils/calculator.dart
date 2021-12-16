import 'bill.dart';

class Calculator {
  var debts = new Map<String, double>();

  get_debts() {
    return debts;
  }

  clear_debts() {
    debts = {};
  }

  void update_debts(data, var bill_data) {
    Bill bill = new Bill(bill_data);
    for (var product in data) {
      String name = product["name"];
      double price = bill.get_product_price(name);
      dynamic parts = 0;
      for (var person in product["participation"].keys) {
        parts = parts + product["participation"][person];
      }
      for (var person in product["participation"].keys) {
        if (debts.containsKey(person)) {
          debts[person] =
              debts[person]! + product["participation"][person] / parts * price;
        } else {
          debts[person] = product["participation"][person] / parts * price;
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
