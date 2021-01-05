$sqlserver = "testing-meggit-db2.database.windows.net"
$username = "ajinkya.joshi"
$password = "Fl@sh@123"
$dbname = "whiskeyball-db-prod"

Install-Module -Name sqlserver -Force

Invoke-Sqlcmd -ServerInstance $sqlserver -Username $username -Password $password -Database $dbname -InputFile "FinalScript.sql"
