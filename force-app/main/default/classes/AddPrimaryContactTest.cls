@isTest
public class AddPrimaryContactTest {
    
    @testSetup
    static void setupTestData() {
        // Insert 50 accounts for NY and 50 for CA
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'Test Account NY' + i, BillingState = 'NY'));
        }
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'Test Account CA' + i, BillingState = 'CA'));
        }
        insert accounts;
    }
    
    @isTest
    static void testAddPrimaryContact() {
        // Create a test contact
        Contact testContact = new Contact(FirstName = 'John', LastName = 'Doe', Email = 'johndoe@test.com');
        
        // Create an instance of the Queueable class for BillingState 'CA'
        AddPrimaryContact job = new AddPrimaryContact(testContact, 'CA');
        
        // Start the test to simulate async processing
        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();
        
        // Query to verify that 50 contacts have been inserted for CA
        Integer insertedContactsCount = [SELECT COUNT() FROM Contact WHERE Account.BillingState = 'CA'];
        
        // Assert that 50 contacts were inserted
        System.assertEquals(50, insertedContactsCount);
    }
}