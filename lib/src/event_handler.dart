import 'calculator.dart';

class EventHandler {
  String name = '';
  List participators = [];
  var start_date;
  var end_date;
  List purchases = [];
  var overall_debts = new Map<String, double>();

  //инициализация события: название события, дата начала, участники
  void initialize_event(String name_of_event, var event_date, persons) {
    name = name.toString();
    start_date = event_date;
    participators.addAll(persons);
    generate_overall_debts();
  }

  //генерация начального списка долгов с нулевыми значениями
  void generate_overall_debts() {
    for (var person in participators) {
      overall_debts[person] = 0.0;
    }
  }

  //добавление события связанного с покупкой, нужно название события и список долгов, сгенерированный в калькуляторе
  void add_purchase(String purchase_name, debts) {
    purchases.add([purchase_name, debts]);
  }

  get_purchases() {
    return purchases;
  }

  // итоговый подсчет долгов
  void calculate_overall_debts() {
    for (var purchase in purchases) {
      purchase[1]
          .forEach((String person, debt) => overall_debts[person] += debt);
    }
  }

 // итоговый подсчет кто кому и сколько должен
  get_overall_transacions() {
    Calculator calc = new Calculator();
    calc.set_debts(overall_debts);
    return calc.calculate_transactions();
  }

  get_overall_debts() {
    return overall_debts;
  }

// объявление даты окончания события
  void end_event(var date) {
    end_date = date;
  }
}
