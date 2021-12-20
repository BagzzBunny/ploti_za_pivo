import 'bill.dart';

class Calculator {
  var debts = new Map<String, double>();

  get_debts() {
    return debts;
  }

  clear_debts() {
    debts = {};
  }

  void update_debts(var participation_data, var bill_data) {
    Bill bill = new Bill(bill_data);
    for (var product in participation_data) {
      String name = product["name"];
      double price = bill.get_product_price(name);
      dynamic parts = 0;
      for (var person in product["participation"].keys) {
        parts = parts + product["participation"][person];
      }
      for (var person in product["participation"].keys) {
        if (debts.containsKey(person)) {
          debts[person] = double.parse(
              (debts[person] + product["participation"][person] / parts * price)
                  .toStringAsFixed(2));
        } else {
          debts[person] = double.parse(
              (product["participation"][person] / parts * price)
                  .toStringAsFixed(2));
        }
      }
    }
  }

  void send_payment(payment_data) {
    for (var person in payment_data.keys) {
      if (debts.containsKey(person)) {
        debts[person] = double.parse(
            (debts[person] + payment_data[person]).toStringAsFixed(2));
      } else {
        debts[person] = double.parse((payment_data[person]).toStringAsFixed(2));
      }
    }
  }

  void set_debts(debt) {
    debts = debt;
  }

  calculate_transactions() {
    List m = [];
    debts.forEach((person, debt) {
      m.add([debt, person]);
    });
    double sum = 0;
    m.forEach((element) {
      sum += element[0];
    });
    if (sum != 0) {
      return 'error';
    }
    ;
    double positive_nums = 0;
    m.forEach((element) {
      if (element[0] >= 0) {
        positive_nums += element[0];
      }
    });
    List transactions = [];
    for (int i = 0; i < m.length; i++) {
      if (m[i][0] <= 0) {
        transactions.add([m[i][1], 0.0]);
      }
      if (m[i][0] > 0) {
          Map transaction = {};
          for (int j = 0; j < m.length; j++) {
            if (m[j][0] < 0) {
              if (m[j][0]*-1 < m[i][0]) {
                transaction[m[j][1]] = m[j][0]*-1;
                m[i][0] = m[i][0] - m[j][0]*-1;
                m[j][0] = 0;
              }
              if (m[j][0]*-1 > m[i][0]) {
                transaction[m[j][1]] = m[i][0];
                m[i][0] = m[j][0]*-1 - m[i][0];
                m[i][0] = 0;
              }
            }
          }
          transactions.add([m[i][1], transaction]);
        }
      
    }
    return transactions;
  }
}
