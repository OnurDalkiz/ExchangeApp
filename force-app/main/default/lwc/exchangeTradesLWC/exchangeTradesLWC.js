import { api, LightningElement, track, wire } from 'lwc';
import convert from '@salesforce/apex/CurrencyRestService.convert';
import getSymbols from '@salesforce/apex/CurrencyRestService.getSymbols';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { createRecord } from 'lightning/uiRecordApi';

export default class exchangeTradesLWC extends LightningElement {
    //sell symbols
    sellCurrency = '';
    //buy symbols
    buyCurrency = '';
    //sell amount
    @track amount = '';
    @track buyAmount;
    //sell-buy currency rate
    @track rate;
    //component visibility
    @api DisplayText = false;

    //sell-buy currency unit, symbols
    @track symbols = [{}];

    //currency unit from external system
    @wire(getSymbols, {})
    element({ error, data }) {
        let key = [];
        let val = [];
        if (error) {
            alert('External Method Exception')
        } else if (data) {
            //parser data from external system
            key.push(Object.keys(data))
            val.push(Object.values(data)) 
            for (let i = 0; i < key[0].length; i++) {
                //currency unit options are matched
                this.symbols.push({
                    value: (key[0])[i],
                    label: (val[0])[i]
                })
            }
        }
    }

    //combobox currency unit options
    get options() {
        return this.symbols;
    }

    //component visibility function
    @api LWCFunction() {
        if (this.DisplayText != true) {
            this.DisplayText = true;
        }
    }

    //component visibility function
    cancel() {
        if (this.DisplayText != false) {
            this.DisplayText = false;
        }
    }

    //sell currency unit function
    handleSellChange(event) {
        this.sellCurrency = event.detail.value;
        if (this.buyCurrency != '') {
            convert({
                sellCurrency: this.sellCurrency,
                buyCurrency: this.buyCurrency,
                amount: 1
            }).then(result => {
                this.rate = result / 1;
                this.buyAmount = this.amount * this.rate;
            });
        }
    }

    //buy currency unit function
    handleBuyChange(event) {
        this.buyCurrency = event.detail.value;
        if (this.sellCurrency != '') {
            convert({
                sellCurrency: this.sellCurrency,
                buyCurrency: this.buyCurrency,
                amount: 1                
            }).then(result => {
                this.rate = result / 1;
                this.buyAmount = this.amount * this.rate;
            });
        }
    }


    //amount change function
    handleAmountChange(event) {
        this.amount = event.detail.value;
        if (this.rate != null) {
            this.buyAmount = this.amount * this.rate;
        }
    }

    //create Foreign_Exchange_Trades__c custom object function
    createExchange() {
        var fields = {
            //fetch data
            'Sell_Currency__c': this.sellCurrency,
            'Sell_Amount__c': this.amount,
            'Buy_Currency__c': this.buyCurrency,
            'Buy_Amount__c': this.buyAmount,
            'Rate__c': this.rate,
            'Date_Booked__c': new Date()
        };

        //validity of all data
        let isValid = true;
        let inputFields = this.template.querySelectorAll('.validate');
        inputFields.forEach(inputField => {
            if (!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
        });
        //all fields are full
        if (isValid != false) {
            // Record details to pass to create method with api name of Object.
            var objRecordInput = { 'apiName': 'Foreign_Exchange_Trades__c', fields };
            // LDS method to create record.
            createRecord(objRecordInput).then(response => {
                alert('Foreign Exchange Trades is Created');
                //UI toast message
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'Foreign Exchange Trades is Created',
                    variant: 'success'
                }));
                //aura component refresh function
                const myevent = new CustomEvent('needToRefreshTable');
                this.dispatchEvent(myevent);
            }).catch(error => {
                alert('Error: ' + JSON.stringify(error));

                this.dispatchEvent(new ShowToastEvent({
                    title: 'Error',
                    message: 'Foreign Exchange Trades is Not Created',
                    variant: 'error'
                }));
            });

        //all fields are not full
        } else {
            alert('Fill in the mandatory fields')
        }


    }
}