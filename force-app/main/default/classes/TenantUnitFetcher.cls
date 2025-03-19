public class TenantUnitFetcher {
    public class TenantUnitResult {
        @InvocableVariable(label='Tenants' description='List of Tenant_Info__c records')
        public List<Tenant_Info__c> tenants;
        
        @InvocableVariable(label='Units' description='List of Unit__c records')
        public List<Unit__c> units;
    }

    @InvocableMethod(label='Fetch Tenant and Unit Details' description='Fetches Tenant_Info__c and Unit__c records based on due Payment_Detail__c records')
    public static List<TenantUnitResult> fetchTenantAndUnitDetails(List<String> input) {
        TenantUnitResult result = new TenantUnitResult();
        
        // Fetch Payment_Detail__c records where Payment_Status__c is 'Due'
        List<Payment_Detail__c> duePayments = [
            SELECT Id, Tenant__c, Unit__c 
            FROM Payment_Detail__c 
            WHERE Payment_Status__c = 'Due'
        ];
        
        // Collect Tenant and Unit IDs
        Set<Id> tenantIds = new Set<Id>();
        Set<Id> unitIds = new Set<Id>();
        
        for (Payment_Detail__c payment : duePayments) {
            if (payment.Tenant__c != null) {
                tenantIds.add(payment.Tenant__c);
            }
            if (payment.Unit__c != null) {
                unitIds.add(payment.Unit__c);
            }
        }
        
        // Fetch related Tenant_Info__c records
        result.tenants = new List<Tenant_Info__c>();
        if (!tenantIds.isEmpty()) {
            result.tenants = [SELECT Id, Name FROM Tenant_Info__c WHERE Id IN :tenantIds];
        }
        
        // Fetch related Unit__c records
        result.units = new List<Unit__c>();
        if (!unitIds.isEmpty()) {
            result.units = [SELECT Id, Name FROM Unit__c WHERE Id IN :unitIds];
        }
        
        return new List<TenantUnitResult>{result};
    }
}