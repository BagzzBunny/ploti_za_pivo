import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'dart:io';
import 'package:ploti_za_pivo/shelf.dart';

readFileSync(file_path) {
  String contents = new File(file_path).readAsStringSync();
  var respond = jsonDecode(contents);
  return respond;
}

void main() {
  test('PaymentHandler test zero inputs', () {
    var payment_data = readFileSync(
        p.absolute("test", "data/payment_handler_tests/zeros/payment.json"));
    var result_pre = readFileSync(
        p.absolute("test", "data/payment_handler_tests/zeros/result.json"));
    var payment = PaymentHandler.handle_payment_data(payment_data);
    expect(payment, result_pre);
  });

  test('PaymentHandler regular inputs', () {
    var payment_data = readFileSync(
        p.absolute("test", "data/payment_handler_tests/regular/payment.json"));
    var result_pre = readFileSync(
        p.absolute("test", "data/payment_handler_tests/regular/result.json"));
    var payment = PaymentHandler.handle_payment_data(payment_data);
    expect(payment, result_pre);
  });

  test('PaymentHandler negative inputs', () {
    var payment_data = readFileSync(
        p.absolute("test", "data/payment_handler_tests/negative/payment.json"));
    var result_pre = readFileSync(
        p.absolute("test", "data/payment_handler_tests/negative/result.json"));
    var payment = PaymentHandler.handle_payment_data(payment_data);
    expect(payment, result_pre);
  });

  test('Bill/get_bill_data', () {
    var bill_data = readFileSync(
        p.absolute("test", "data/bill_tests/get_bill_data/bill.json"));
    var result_pre = readFileSync(
        p.absolute("test", "data/bill_tests/get_bill_data/result.json"));
    Bill bill = Bill(bill_data);
    var result_act = bill.get_bill_data();
    expect(result_act, result_pre);
  });

  test('Bill/get_product_price', () {
    var bill_data = readFileSync(
        p.absolute("test", "data/bill_tests/get_product_price/bill.json"));
    var result_pre = readFileSync(p.absolute(
        "test", "data/bill_tests/get_product_price/result.json"))["price"];
    var name = readFileSync(p.absolute("test",
        "data/bill_tests/get_product_price/name_for_test.json"))["name"];
    Bill bill = Bill(bill_data);
    var result_act = bill.get_product_price(name);
    expect(result_act, result_pre);
  });

  test('Bill/get_product_price', () {
    var bill_data = readFileSync(
        p.absolute("test", "data/bill_tests/get_product_qty/bill.json"));
    var result_pre = readFileSync(p.absolute(
        "test", "data/bill_tests/get_product_qty/result.json"))["qty"];
    var name = readFileSync(p.absolute(
        "test", "data/bill_tests/get_product_qty/name_for_test.json"))["name"];
    Bill bill = Bill(bill_data);
    var result_act = bill.get_product_qty(name);
    expect(result_act, result_pre);
  });

  test('calculator', () {
    var bill_data =
        readFileSync(p.absolute("test", "data/calculator_tests/bill.json"));
    var result_pre =
        readFileSync(p.absolute("test", "data/calculator_tests/result.json"));
    var payment =
        readFileSync(p.absolute("test", "data/calculator_tests/payment.json"));
    var participation = readFileSync(
        p.absolute("test", "data/calculator_tests/participation.json"));
    Bill bill = new Bill(bill_data);
    Calculator calc = new Calculator();
    calc.update_debts(participation, bill.get_bill_data());
    var handled_payment_data = PaymentHandler.handle_payment_data(payment);
    calc.send_payment(handled_payment_data);
    expect(calc.get_debts(), result_pre);
  });

  test('clearing debts', () {
    var bill_data =
        readFileSync(p.absolute("test", "data/calculator_tests/bill.json"));
    var participation = readFileSync(
        p.absolute("test", "data/calculator_tests/participation.json"));
    Bill bill = new Bill(bill_data);
    Calculator calc = new Calculator();
    calc.update_debts(participation, bill.get_bill_data());
    calc.clear_debts();
    expect(calc.get_debts(), {});
  });

  test('test calculate who pays who', () {
    Calculator calc = new Calculator();
    calc.set_debts({'Vasya': -75.0, 'Petya': 55.0, 'Masha': 20.0});
    expect(calc.calculate_transactions(), [['Vasya', 0.0], ['Petya', {'Vasya': 55.0}], ['Masha', {'Vasya': 20.0}]]);
  });
}
