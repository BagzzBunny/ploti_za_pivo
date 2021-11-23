from utils.bill_reader import BillReader
from utils.debt_calculator import DebtCalculator
from utils.payment_reader import PaymentReader as pr


bill_reader = BillReader("test\\data\\bill.json")
calculator = DebtCalculator("test\\data\\participation.json", "test\\data\\bill.json")
debt = calculator.get_debts()
print(debt)
payment = pr.get_payment("test\\data\\payment.json")
calculator.update_debts(payment)
debt = calculator.get_debts()
print(debt)