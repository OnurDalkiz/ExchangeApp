@isTest
private class testCurrencyRestService{
        @isTest
        static void test1() {
            
          // Arrange
          Foreign_Exchange_Trades__c exchange = new Foreign_Exchange_Trades__c();
          exchange.Sell_Currency__c = 'USD';
          exchange.Sell_Amount__c = 100;
          exchange.Buy_Currency__c = 'USD';
          exchange.Buy_Amount__c = 100;
            
          insert exchange;
        
          RestContext.request = new RestRequest();
          RestContext.response = new RestResponse();
          RestContext.request.requestURI = '/services/apexrest/House/' + exchange.Id;
          RestContext.request.httpMethod = 'GET';
        
          //Act
          Test.startTest();
          CurrencyRestService.convert('USD','USD','100');
          Test.stopTest();
        
          // Assert
          Foreign_Exchange_Trades__c restExchange = (Foreign_Exchange_Trades__c) JSON.deserialize(
            RestContext.response.responseBody.toString(),
            Foreign_Exchange_Trades__c.class
          );
          System.assertEquals(200, RestContext.response.statusCode);
          System.assertEquals(exchange.Id, restExchange.Id);
        }
    
    	@isTest
        static void test2() {
            
          // Arrange
          Foreign_Exchange_Trades__c exchange = new Foreign_Exchange_Trades__c();
          exchange.Sell_Currency__c = 'USD';
          exchange.Sell_Amount__c = 100;
          exchange.Buy_Currency__c = 'USD';
          exchange.Buy_Amount__c = 100;
            
          insert exchange;
        
          RestContext.request = new RestRequest();
          RestContext.response = new RestResponse();
          RestContext.request.requestURI = '/services/apexrest/House/' + exchange.Id;
          RestContext.request.httpMethod = 'GET';
        
          //Act
          Test.startTest();
          CurrencyRestService.getSymbols();
          Test.stopTest();
        
          // Assert
          Foreign_Exchange_Trades__c restExchange = (Foreign_Exchange_Trades__c) JSON.deserialize(
            RestContext.response.responseBody.toString(),
            Foreign_Exchange_Trades__c.class
          );
          System.assertEquals(200, RestContext.response.statusCode);
          System.assertEquals(exchange.Id, restExchange.Id);
        }
    
}