class Bill {
  var bill_data = [];

  Bill(data) {
    bill_data = data;
  }

  get_bill_data() {
    return bill_data;
  }

  get_product_price(String name) {
    for (var product in bill_data) {
      if (product["name"] == name) {
        return product["price"];
      }
    }
  }

  get_product_qty(String name) {
    for (var product in bill_data) {
      if (product["name"] == name) {
        return product["qty"];
      }
    }
  }
}
