import json


class BillReader():
    def __init__(self, file_path):
        with open(file_path) as file:
            self.bill_data = json.loads(file.read())

    def get_bill_data(self):
        return self.bill_data
