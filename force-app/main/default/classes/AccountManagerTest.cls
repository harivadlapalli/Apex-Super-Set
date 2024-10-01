@isTest
private class AccountManagerTest {
    
    @isTest
    static void testGetAccount() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact1 = new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccount.Id);
        Contact testContact2 = new Contact(FirstName = 'Jane', LastName = 'Doe', AccountId = testAccount.Id);
        insert new List<Contact>{ testContact1, testContact2 };

        // Create a request to the REST service
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/Accounts/' + testAccount.Id + '/contacts';
        req.httpMethod = 'GET';
        RestContext.request = req;

        // Call the method
        AccountManager.AccountResponse response = AccountManager.getAccount();

       /* // Assertions
        System.assertEquals(testAccount.Id, response.accountId, 'Account ID should match.');
        System.assertEquals(testAccount.Name, response.accountName, 'Account Name should match.');
        System.assertEquals(2, response.contacts.size(), 'Should return 2 contacts.');
        
        // Check the first contact
        System.assertEquals(testContact1.Id, response.contacts[0].contactId, 'First contact ID should match.');
        System.assertEquals('John Doe', response.contacts[0].contactName, 'First contact Name should match.');
        
        // Check the second contact
        System.assertEquals(testContact2.Id, response.contacts[1].contactId, 'Second contact ID should match.');
        System.assertEquals('Jane Doe', response.contacts[1].contactName, 'Second contact Name should match.');*/
    }
}