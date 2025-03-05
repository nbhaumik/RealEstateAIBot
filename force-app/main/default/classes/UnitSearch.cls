public class UnitSearch {

    @InvocableMethod(label='Get Unit Names' description='Returns the list of Unit names corresponding to the specified Units' category='Unit__c')
    public static List<Unit__c> getUnits(List<String> unitIds) {
        
        List<Unit__c> unitRecords = new List<Unit__c>();
        if(unitIds.isEmpty())
        {
            unitRecords = [SELECT Unit_Name__c, Unit_Status__c, Rent_Amount__c, Property_Name__c, Bedrooms__c, Bathrooms__c FROM Unit__c];
        }
        else
        {
            unitRecords = [SELECT Unit_Name__c, Unit_Status__c, Rent_Amount__c, Property_Name__c, Bedrooms__c, Bathrooms__c FROM Unit__c WHERE Unit_Name__c in :unitIds];
        }
        return unitRecords;
    }
    
    /*@InvocableMethod(label='Get Units by Status' description='Returns the list of Unit names corresponding to the specified status' category='Unit__c')
    public static List<Unit__c> getUnitByStatus(List<String> unitStatus) {
        
        List<Unit__c> unitRecords = new List<Unit__c>();
        
        unitRecords = [SELECT Unit_Name__c, Unit_Status__c, Rent_Amount__c, Property_Name__c, Bedrooms__c, Bathrooms__c FROM Unit__c WHERE Unit_Status__c in :unitStatus];
        return unitRecords;
    }*/
}