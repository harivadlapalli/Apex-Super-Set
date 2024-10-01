@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    
    @HttpGet
    global static AccountResponse getAccount() {
        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
        
        // Query the account and associated contacts
        Account acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id = :accountId LIMIT 1];
        
        // Create response object
        AccountResponse response = new AccountResponse();
        response.accountId = acc.Id;
        response.accountName = acc.Name;
        response.contacts = new List<ContactInfo>();
        
        for (Contact c : acc.Contacts) {
            ContactInfo contactInfo = new ContactInfo();
            contactInfo.contactId = c.Id;
            contactInfo.contactName = c.Name;
            response.contacts.add(contactInfo);
        }
        
        return response;
    }
    
    global class AccountResponse {
        global String accountId;
        global String accountName;
        global List<ContactInfo> contacts;
    }

    global class ContactInfo {
        global String contactId;
        global String contactName;
    }
}