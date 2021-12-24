import 'calculator.dart';

class EventHandler {
  String name = '';
  List participators = [];
  var startDate;
  var endDate;
  List purchases = [];
  var overallDebts = Map<String, double>();

  //инициализация события: название события, дата начала, участники
  void initialize_event(String nameOfEvent, var eventDate, persons) {
    name = name.toString();
    startDate = eventDate;
    participators.addAll(persons);
    generate_overall_debts();
  }

  //генерация начального списка долгов с нулевыми значениями
  void generate_overall_debts() {
    for (var person in participators) {
      overallDebts[person] = 0.0;
    }
  }

  //добавление события связанного с покупкой, нужно название события и список долгов, сгенерированный в калькуляторе
  void add_purchase(String purchaseName, debts) {
    purchases.add([purchaseName, debts]);
  }

  get_purchases() {
    return purchases;
  }

  // итоговый подсчет долгов
  void calculate_overall_debts() {
    for (var purchase in purchases) {
      purchase[1]
          .forEach((String person, debt) {
            var a = overallDebts[person] ?? 0;
            a += debt;
            overallDebts[person] = a;
          });
    }
  }

 // итоговый подсчет кто кому и сколько должен
  get_overall_transacions() {
    Calculator calc = new Calculator();
    calc.set_debts(overallDebts);
    return calc.calculate_transactions();
  }

  get_overall_debts() {
    return overallDebts;
  }

// объявление даты окончания события
  void end_event(var date) {
    endDate = date;
  }
}
