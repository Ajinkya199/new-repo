[CmdletBinding()]
        Param(
          [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
          [String] $pass
    	)
        
$sqlserver = "testing-meggit-db.database.windows.net"
$username = "ajinkya.joshi"

#Scripts Folder Path
$FolderPath ="/home/vsts/work/1/s/scripts/sql/init"

Install-Module -Name sqlserver -Force

If (${env:PURGE} -eq "true") 
{
        #Loop through the .sql files and run them
        foreach ($filename in get-childitem -path $FolderPath -Recurse -filter "*.sql")
        {
                Invoke-Sqlcmd -ServerInstance $sqlserver -Username $username -Password $pass -Database ${env:BUILD_SOURCEBRANCHNAME} -InputFile $filename.fullname
                #Print file name which is executed
                $filename 
        } 
}
Else 
{
Write-Host "Database ${env:BUILD_SOURCEBRANCHNAME} unchanged"
} 
