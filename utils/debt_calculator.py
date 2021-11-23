import json


class DebtCalculator():

    def __init__(self, file_path, bill):
        with open(file_path) as file:
            self.participation_data = json.loads(file.read())
        self.debts = []
        for product in self.participation_data:
            name = product["name"]
            for person in product["participation"]:
                if person not in self.debts:
                    self.debts.append(person)
        

    def get_debts(self):
        return self.debts