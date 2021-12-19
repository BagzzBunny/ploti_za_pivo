class PaymentHandler {
  // преобразует данные вида [{"payer": "payer_name", "amount": double}]
  // в {"payer_name": double}
  static handle_payment_data(payment_data) {
    var payment = new Map<String, double>();
    for (var element in payment_data) {
      var payer = [];
      for (var data in element.keys) {
        payer.add(element[data]);
      }
      payment[payer[0]] = payer[1] * -1;
    }
    return payment;
  }
}
