public with sharing class callExchange{

    //Records created with lwc new trade component are pulled from Database with SOQL query
    @AuraEnabled
    public static List<Foreign_Exchange_Trades__c>  exchangeObject(){

        //called in the Foreign_Exchange_Trades__c custom object data, sorting Date_Booked__c field
        return [SELECT Name, Sell_Currency__c,
                Sell_Amount__c, Rate__c,Buy_Currency__c, Buy_Amount__c, Date_Booked__c FROM Foreign_Exchange_Trades__c  ORDER BY Name DESC];
      
    }                         
}