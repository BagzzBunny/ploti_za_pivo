from utils.bill_reader import BillReader


bill_reader = BillReader("test\\data\\bill.json")
data = bill_reader.get_bill_data()
print(data)