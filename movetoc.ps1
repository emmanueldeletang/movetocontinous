
 # Connect-AzAccount -TenantId 3xxxxxxxd87'    

# select-AzSubscription -SubscriptionId



$subscriptionList=@("7471xxxxxxe")


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

