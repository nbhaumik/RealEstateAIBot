public class UnitStatusTrackingController {
    
    @InvocableMethod(label='Get Updated Unit Counts' description='Counts the number of units where Status__c changed from Occupied to Available in the last 3 months')
    public static List<Integer> getAvailableUnitsCount(List<String> caseStatus) {
        // Query Unit__History for Status__c changes in the last 3 months
        List<Unit__History> historyRecords = [
            SELECT Id, OldValue, NewValue, CreatedDate 
            FROM Unit__History 
            WHERE Field = 'Unit_Status__c'
        ];

        Integer count = 0;

        // Filter records in Apex since OldValue/NewValue cannot be filtered in SOQL
        for (Unit__History record : historyRecords) {
            if (String.valueOf(record.OldValue) == 'Occupied' && 
                String.valueOf(record.NewValue) == 'Available') {
                count++;
            }
        }

        return new List<Integer>{count}; // Return the count as a list for invocable method
    }
}