import json


class PaymentReader():
    @classmethod
    def get_payment(cls, payment_path):
        with open(payment_path) as file:
            payment_data = json.loads(file.read())
        payment = {}
        for element in payment_data:
            payer = []
            for data in element:
                payer.append(element[data])
            payment.update({payer[0]: payer[1]*-1})
        return payment