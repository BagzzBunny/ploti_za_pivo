interface BillElement {
    name: string
    qty: Number
    price: Number
}
type Bill = BillElement[]

interface PaymentElement {
    payer: string
    amount: Number
}
type Payment = PaymentElement[]

interface Participation {
    [name: string] : {
        [person: string]: Number
    }
}

interface PreliminaryResult {
    [person: string]: Number
}

function calculate(
    bill: Bill, 
    payment: Payment, 
    participation: Participation) : PreliminaryResult {
        const positions = bill.map(x => x.name)
        console.log(positions)
        const persons = payment.map(x => x.payer)
        //persons.push(Object.values(participation).map(x => Object.keys(x)).flat())
        console.log(persons)
        return {}
}

import { readFileSync } from 'fs';

var bill = JSON.parse(readFileSync('test/data/bill.json').toString());
var payment = JSON.parse(readFileSync('test/data/payment.json').toString());
var participation = JSON.parse(readFileSync('test/data/participation_v2.json').toString());

calculate(bill, payment, participation)
