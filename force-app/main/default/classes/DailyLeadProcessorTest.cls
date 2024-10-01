@IsTest
private class DailyLeadProcessorTest {
    
    @IsTest
    static void testLeadProcessor() {
        // Create 200 Lead records with blank LeadSource
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(FirstName = 'Test', LastName = 'Lead' + i, Company = 'Test Company'));
        }
        insert testLeads;
        
        // Start test context
        Test.startTest();
        
        // Schedule the DailyLeadProcessor class
        String cronExp = '0 0 0 * * ?'; // This will schedule the job to run daily at midnight
        String jobId = System.schedule('Daily Lead Processor', cronExp, new DailyLeadProcessor());
        
        // Stop test context to run the job synchronously
        Test.stopTest();
        
        // Query the leads and verify if they were updated
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, updatedLeads.size(), 'Not all leads were updated');
    }
}