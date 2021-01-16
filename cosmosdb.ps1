$resourceGroupName = "pipeline-testing-aj"
$accountName = "meggit-12345"

Install-Module -Name Az.CosmosDB -Force

$cosmosdb = Get-AzCosmosDBMongoDBDatabase -ResourceGroupName $resourceGroupName -AccountName $accountName -Name ${env:BUILD_SOURCEBRANCHNAME} -ErrorAction SilentlyContinue

if ( $cosmosdb -eq $null )
{
    New-AzCosmosDBMongoDBDatabase -ResourceGroupName $resourceGroupName -AccountName $accountName -Name ${env:BUILD_SOURCEBRANCHNAME}
}
else 
{ 
    echo " Cosmos database ${env:BUILD_SOURCEBRANCHNAME} already exits"
}
