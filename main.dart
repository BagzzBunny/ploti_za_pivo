import 'package:ploti_za_pivo/shelf.dart';

void main() {
  Bill my_bill = new Bill([
    {"name": "A", "qty": 5, "price": 100.0},
    {"name": "B", "qty": 1, "price": 30.0},
    {"name": "C", "qty": 1, "price": 10.0}
  ]);
  var bill_data = my_bill.get_bill_data();
  var data = [
    {
      "name": "A",
      "participation": {"Vasya": 5, "Petya": 5}
    },
    {
      "name": "B",
      "participation": {"Masha": 1}
    },
    {
      "name": "C",
      "participation": {"Vasya": 1, "Petya": 1}
    }
  ];
  Calculator calc = new Calculator();
  calc.update_debts(data = data, bill_data = bill_data);
  print(calc.get_debts());
  var payment_data = [
    {"payer": "Vasya", "amount": 130.0},
    {"payer": "Masha", "amount": 10.0}
  ];
  print('payment:');
  var handled_payment_data = PaymentHandler.handle_payment_data(payment_data);
  calc.send_payment(handled_payment_data);
  print(calc.get_debts());
}
