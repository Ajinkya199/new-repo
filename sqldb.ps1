#preprod SQL server / database details
$preprodrg = ""
$preprodserver = "" 
$preproddb = ""
#prod SQL server / database details
$prodrg = ""
$prodserver = ""
$proddb = ""
#dev SQL server / database details
$devrg = ""
$devserver = ""
$devdb = ""
#Target SQL server / database details (to be restored)
$targetrg = "pipeline-testing-aj"
$targetserver = "testing-meggit-db"
$tier = "Basic"

If (${env:DBENV} -eq "old")
{
      echo "Using existing Database ${env:BUILD_SOURCEBRANCHNAME} " 
}
else
{
     Remove-AzSqlDatabase -ResourceGroupName $targetrg -ServerName $targetserver -DatabaseName ${env:BUILD_SOURCEBRANCHNAME} -Force -ErrorAction SilentlyContinue
     echo " Database ${env:BUILD_SOURCEBRANCHNAME} deleted." 
     
    If (${env:DBENV} -eq "new")
    {
        New-AzSqlDatabase -ResourceGroupName $targetrg -ServerName $targetserver -DatabaseName ${env:BUILD_SOURCEBRANCHNAME} -ComputeModel Serverless -Edition GeneralPurpose -ComputeGeneration Gen5 -MinVcore 0.5 -MaxVcore 1 -AutoPauseDelayInMinutes 60
    }
    elseIf (${env:DBENV} -eq "prod") 
    {
        New-AzSqlDatabaseCopy -ResourceGroupName $preprodrg -ServerName $preprodserver -DatabaseName $preproddb -CopyResourceGroupName $targetrg -CopyServerName $targetserver -CopyDatabaseName ${env:BUILD_SOURCEBRANCHNAME}
        echo "Database $proddb Copied "
    }
    elseif (${env:DBENV} -eq "preprod") 
    {
        New-AzSqlDatabaseCopy -ResourceGroupName $prodrg -ServerName $prodserver -DatabaseName $proddb -CopyResourceGroupName $targetrg -CopyServerName $targetserver -CopyDatabaseName ${env:BUILD_SOURCEBRANCHNAME}
        echo "Database $preproddb Copied "
    }
    elseif (${env:DBENV} -eq "dev") 
    {
        New-AzSqlDatabaseCopy -ResourceGroupName $devrg -ServerName $devserver -DatabaseName $devdb -CopyResourceGroupName $targetrg -CopyServerName $targetserver -CopyDatabaseName ${env:BUILD_SOURCEBRANCHNAME}
        echo "Database $devdb Copied "
    }
    else 
    {
         echo " Database Copy / Creation operation not performed " 
    }
}
