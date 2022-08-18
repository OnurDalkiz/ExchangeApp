public with sharing class CurrencyRestService{
    
    //first service receives data in JSON format using the data it receives as a parameter.
    @AuraEnabled(cacheable=true)
    //Example:USD, TRY, 100, "fixer.io --apikey--"
    public static double convert(string sellCurrency, string buyCurrency, string amount) {        
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http http = new Http();
        	//the date we made the transaction
            string today = String.valueOf(System.today());
        	//The data that comes as a parameter is integrated into the endpoint with the url.
            req.setEndpoint('https://api.apilayer.com/fixer/convert?from='+sellCurrency+'&to='+buyCurrency+'&amount='+amount+'&date='+today);
            req.setMethod('GET');
        	//Subscribe to https://api.apilayer.com get "apikey" plase fill in your "apikey".
            req.setHeader('apikey', 'P1xWkiMyzB8yJr0yfP25hyDBnyFWwpEx' );
            res = http.send(req);
        	//Incoming data in JSON format is deserialized
            Map<string, object> responseMap = (Map<string, object>) JSON.deserializeUntyped(res.getbody());
            return (double) responseMap.get('result');     
    }

    @AuraEnabled(cacheable=true)
    public static Object  getSymbols(){  
        	//use the same process as above to buy currencies
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint( 'https://api.apilayer.com/fixer/symbols' );
            req.setMethod('GET');
            //Subscribe to https://api.apilayer.com get "apikey" plase fill in your "apikey".
            req.setHeader('apikey', 'P1xWkiMyzB8yJr0yfP25hyDBnyFWwpEx' );
            HttpResponse res = h.send(req);
            System.debug('response:--> ' + res.getBody());            
            Map < String, Object > resultsMap = (Map < String, Object > ) JSON.deserializeUntyped(res.getBody());
            system.debug('resultsMap-->' + resultsMap);
            return resultsMap.get('symbols');       
		
    }
        
}