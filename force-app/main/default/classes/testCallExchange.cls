@isTest
public class testCallExchange{
    
    @TestSetup
    static void setup(){
        
        // Create test Exchange
        Foreign_Exchange_Trades__c testExchange = new Foreign_Exchange_Trades__c(Sell_Amount__c = 55555);
                                   
        insert testExchange;        
    } 
    
    @isTest static void testMethod1(){
        // Get the first test FeedItem by using a SOQL query
       	List<Foreign_Exchange_Trades__c> test =   new list<Foreign_Exchange_Trades__c>(callExchange.exchangeObject()) ;     
        system.assertEquals(1, test.size());
    }
    

}