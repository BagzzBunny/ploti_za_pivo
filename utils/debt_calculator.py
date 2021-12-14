import json
from .bill_reader import BillReader

class DebtCalculator():

    def __init__(self):       
        self.debts = {}
        
    def get_debts(self):
        return self.debts

    def update_debts(self, update=None, participation_path = None, bill_path = None):       
        if self.debts == {}:
            with open(participation_path) as file:
                participation_data = json.loads(file.read())
            bill = BillReader(bill_path)
            for product in participation_data:
                name = product["name"]
                price = bill.get_product_price(name)
                parts = 0
                for person, part in product["participation"].items():
                    parts += part
                for person, part in product["participation"].items():
                    if person not in self.debts:
                        self.debts.update({person: part/parts * price})
                    else:
                        self.debts[person] += part/parts * price
        else:
            for person, value in update.items():
                if person not in self.debts:
                    self.debts.update({person: value})
                else:
                    self.debts[person] += value

    def clear_debts(self):
        self.debts = {}
        