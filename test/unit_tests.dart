import 'dart:convert';
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
    var payment_data = readFileSync(p.absolute("test", "data/payment_handler_tests/zeros/payment.json"));
    var result_pre = readFileSync(p.absolute("test", "data/payment_handler_tests/zeros/result.json"));
    var payment = PaymentHandler.handle_payment_data(payment_data);
    expect(payment, result_pre);
  });

  test('PaymentHandler regular inputs', () {
    var payment_data = readFileSync(p.absolute("test", "data/payment_handler_tests/regular/payment.json"));
    var result_pre = readFileSync(p.absolute("test", "data/payment_handler_tests/regular/result.json"));
    var payment = PaymentHandler.handle_payment_data(payment_data);
    expect(payment, result_pre);
  });

  test('PaymentHandler negative inputs', () {
    var payment_data = readFileSync(p.absolute("test", "data/payment_handler_tests/negative/payment.json"));
    var result_pre = readFileSync(p.absolute("test", "data/payment_handler_tests/negative/result.json"));
    var payment = PaymentHandler.handle_payment_data(payment_data);
    expect(payment, result_pre);
  });

  
}
