public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String stateAbbreviation;
    
    // Constructor to initialize contact and state abbreviation
    public AddPrimaryContact(Contact contact, String stateAbbreviation) {
        this.contact = contact.clone(false); // Use clone to prevent DML exception
        this.stateAbbreviation = stateAbbreviation;
    }
    
    // Execute method to query Accounts and insert Contact
    public void execute(QueueableContext context) {
        // Query accounts based on the BillingState passed to the constructor
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :stateAbbreviation LIMIT 200];
        
        // List to hold contacts for bulk insertion
        List<Contact> contactsToInsert = new List<Contact>();
        
        // Loop through accounts and prepare contacts for insertion
        for (Account acc : accounts) {
            Contact newContact = contact.clone(false); // Clone the contact object
            newContact.AccountId = acc.Id; // Associate the contact with the account
            contactsToInsert.add(newContact);
        }
        
        // Insert the contacts in bulk
        if (contactsToInsert.size() > 0) {
            insert contactsToInsert;
        }
    }
}