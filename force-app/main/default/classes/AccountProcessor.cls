public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        // Query Accounts with their associated Contacts
        List<Account> accountsToUpdate = new List<Account>();
        for (Account acc : [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountIds]) {
            acc.Number_Of_Contacts__c = acc.Contacts.size();
            accountsToUpdate.add(acc);
        }

        // Update the Account records
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}