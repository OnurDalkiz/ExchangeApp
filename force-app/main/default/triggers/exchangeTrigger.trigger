trigger exchangeTrigger on Foreign_Exchange_Trades__c (after insert) {
	
    List<FeedItem> posts = new List<FeedItem>();
        for(Foreign_Exchange_Trades__c ex: Trigger.New){    
            FeedItem post = new FeedItem();
            Post.ParentId = ex.ownerId;
            post.body = 'Content:A new trade has been created with the following data: ' + '\n' +
						'Sell Currency: ' + ex.Sell_Currency__c + '\n' +
						'Sell Amount: ' + ex.Sell_Amount__c + '\n' +
						'Buy Currency: ' + ex.Buy_Currency__c + '\n' +
						'Buy Amount: ' + ex.Buy_Amount__c + '\n' +
						'Rate: ' + ex.rate__c + '\n' +
						'Booked Date: ' + ex.Date_Booked__c;
            posts.add(post);
        }    
    insert posts;
    
 }