from utils.bill_reader import BillReader
from utils.debt_calculator import DebtCalculator
from utils.payment_reader import PaymentReader as pr


bill_reader = BillReader("test\\data\\bill.json")
calculator = DebtCalculator()
debt = calculator.get_debts()
print(debt)
payment = pr.get_payment("test\\data\\payment.json")
calculator.update_debts(participation_path="test\\data\\participation.json", bill_path="test\\data\\bill.json")
calculator.update_debts(update=payment)
debt = calculator.get_debts()
print(debt)