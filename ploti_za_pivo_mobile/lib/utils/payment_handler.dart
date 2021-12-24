class PaymentHandler {
  // преобразует данные вида [{"payer": "payer_name", "amount": double}]
  // в {"payer_name": double}
  static handle_payment_data(payment_data) {
    var payment = new Map<String, double>();
    for (var element in payment_data) {
      List<String> payer = [];
      for (var data in element.keys) {
        payer.add(element[data].toString());
      }
      if (payment.containsKey(payer[0])) {
        var a  = payment[payer[0]] ?? 0;
        a  -= double.parse(payer[1]);
        payment[payer[0]] = a;
      } else {
        payment[payer[0]] = double.parse(payer[1]) * -1;
      }
    }
    return payment;
  }
}
