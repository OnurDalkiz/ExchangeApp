@isTest
public class testExchangeTrigger {
    
    @TestSetup
    static void setup(){
        
        // Create test Exchange
        Foreign_Exchange_Trades__c testExchange = new Foreign_Exchange_Trades__c(Sell_Amount__c = 55555);
                                   
        insert testExchange;        
    } 
    
    @isTest static void testMethod1() {
        // Get the first test account by using a SOQL query
        
        Foreign_Exchange_Trades__c testExchange = [SELECT OwnerId FROM Foreign_Exchange_Trades__c WHERE Sell_Amount__c = 55555 LIMIT 1];
        List<FeedItem> testFeed = [SELECT Id FROM FeedItem WHERE ParentId =:testExchange.OwnerId];
        
        system.assertEquals(1, testFeed.size(), 'Wrong Process');
    }


    

}