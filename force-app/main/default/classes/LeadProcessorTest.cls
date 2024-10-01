@isTest
private class LeadProcessorTest {

    // Test setup method to insert test data
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        // Insert 200 Leads
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(FirstName = 'First' + i, LastName = 'Last' + i, Company = 'Test Company' + i));
        }
        insert leads;
    }

    @isTest
    static void testLeadProcessor() {
        // Start the test
        Test.startTest();

        // Execute the batch job with default scope
        LeadProcessor batch = new LeadProcessor();
        Id batchId = Database.executeBatch(batch);

        // Stop the test
        Test.stopTest();

        // Assert that all Lead records have been updated with the correct LeadSource
        for (Lead lead : [SELECT LeadSource FROM Lead]) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be Dreamforce');
        }
    }
}