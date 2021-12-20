import 'calculator.dart';

class EventHandler {
  String name = '';
  List participators = [];
  var start_date;
  var end_date;
  List purchases = [];
  var overall_debts = new Map<String, double>();

  void initialize_event(String name_of_event, var event_date, persons) {
    name = name.toString();
    start_date = event_date;
    participators.addAll(persons);
    generate_overall_debts();
  }

  void generate_overall_debts() {
    for (var person in participators) {
      overall_debts[person] = 0.0;
    }
  }

  void add_purchase(String purchase_name, debts) {
    purchases.add([purchase_name, debts]);
  }

  get_purchases() {
    return purchases;
  }

  void calculate_overall_debts() {
    for (var purchase in purchases) {
      purchase[1]
          .forEach((String person, debt) => overall_debts[person] += debt);
    }
  }

  get_overall_transacions() {
    Calculator calc = new Calculator();
    calc.set_debts(overall_debts);
    return calc.calculate_transactions();
  }

  get_overall_debts() {
    return overall_debts;
  }

  void end_event(var date) {
    end_date = date;
  }
}
