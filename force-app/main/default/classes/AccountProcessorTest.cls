@isTest
public class AccountProcessorTest {
    @isTest
    public static void testCountContacts() {
        // Create test data
        Account acc1 = new Account(Name = 'Test Account 1');
        Account acc2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{acc1, acc2};

        // Create associated contacts for the accounts
        Contact con1 = new Contact(LastName = 'Contact 1', AccountId = acc1.Id);
        Contact con2 = new Contact(LastName = 'Contact 2', AccountId = acc1.Id);
        Contact con3 = new Contact(LastName = 'Contact 3', AccountId = acc2.Id);
        insert new List<Contact>{con1, con2, con3};

        // Call the future method
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{acc1.Id, acc2.Id});
        Test.stopTest();

        // Verify that the Account records were updated
        Account updatedAcc1 = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :acc1.Id];
        Account updatedAcc2 = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :acc2.Id];

        System.assertEquals(2, updatedAcc1.Number_Of_Contacts__c, 'Account 1 should have 2 contacts');
        System.assertEquals(1, updatedAcc2.Number_Of_Contacts__c, 'Account 2 should have 1 contact');
    }
}