import json


class BillReader():
    def __init__(self, file_path):
        with open(file_path) as file:
            self.bill_data = json.loads(file.read())

    def get_bill_data(self):
        return self.bill_data

    def get_product_price(self, name):
        for product in self.bill_data:
            if product["name"] == name:
                return product["price"]

    def get_product_qty(self, name):
        for product in self.bill_data:
            if product["name"] == name:
                return product["qty"]