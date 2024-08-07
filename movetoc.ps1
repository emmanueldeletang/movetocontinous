 #Connect-AzAccount  -Tenant "9b802d8b-33fa-40fb-acb7-9ffdbd1919eb" 
 # Connect-AzAccount -TenantId 329f89de-57f6-4294-a279-d6d503c54d87'    

# select-AzSubscription -SubscriptionId



$subscriptionList=@("747112cf-d2bc-49fa-9001-e8602a3c8a0e")

# foreach ($subscription in get-AzSubscription -TenantId 9b802d8b-33fa-40fb-acb7-9ffdbd1919eb) 
foreach ($subscription in $subscriptionList) 
{
    select-AzSubscription -SubscriptionId $subscription #$subscription.Id
        $documentDBAccountRGs = Get-AzResource -ResourceType "Microsoft.DocumentDB/databaseAccounts" | Select-Object  ResourceGroupName -Unique
        $documentDBAccountRGs = $documentDBAccountRGs.ResourceGroupName
        
      

        foreach($documentDBAccountRG in $documentDBAccountRGs)
        {
        
        $accounts = Get-AzCosmosDBAccount -ResourceGroupName "$documentDBAccountRG"
        
        
        foreach ( $account in $accounts)
        {

            write-output "compte to change"
            write-output $account.Name
            
            az cosmosdb update -n $account.Name -g $documentDBAccountRG --backup-policy-type continuous

            az cosmosdb show -n $account.Name -g $documentDBAccountRG


        }
        }
    
}

