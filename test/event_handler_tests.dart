import 'package:test/test.dart';
import 'package:ploti_za_pivo/shelf.dart';

void main() {
  test('расчет долгов', () {
    EventHandler event = new EventHandler();
    event.initialize_event(
        'Поездка на Луну', '23-08-2021', ['Вася', 'Петя', 'Боря', 'Дима']);
    event.add_purchase('поход в бар',
        {'Вася': 55.0, 'Петя': 5000, 'Боря': -5550, 'Дима': 500});
    event.add_purchase(
        'поход в кратер', {'Вася': 1.0, 'Петя': -10, 'Боря': 2.0, 'Дима': 3.0});
    event.add_purchase('трамплин на Солнце',
        {'Вася': 600.0, 'Петя': 66, 'Боря': 3434, 'Дима': -4900});
    event.calculate_overall_debts();
    expect(event.get_overall_debts(),
        {'Вася': 656.0, 'Петя': 5056.0, 'Боря': -2114, 'Дима': -4397});
  });

  test('test generate overall debts', () {
    EventHandler event = new EventHandler();
    event.initialize_event(
        'Поездка на Луну', '23-08-2021', ['Вася', 'Петя', 'Боря', 'Дима']);
    expect(event.get_overall_debts(),
        {'Вася': 0, 'Петя': 0, 'Боря': 0, 'Дима': 0});
  });
}
