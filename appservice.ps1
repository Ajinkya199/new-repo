$rg = "pipeline-testing-aj"
$location = "UK South"

$abc = ${env:BUILD_SOURCEBRANCHNAME}
$webapp=$abc.Replace("_","-")

$appservice = Get-AzWebApp -ResourceGroupName $rg -Name ${env:BUILD_SOURCEBRANCHNAME} -ErrorAction SilentlyContinue

if($appservice -eq $null)
{
# create app service plan
New-AzAppServicePlan -ResourceGroupName $rg -Name ${env:BUILD_SOURCEBRANCHNAME} -Location $location -Tier "Free"

# Create app service
New-AzWebApp -ResourceGroupName $rg -Name $webapp -Location $location -AppServicePlan ${env:BUILD_SOURCEBRANCHNAME}
}
else
{
    Write-Host "AppService ${env:BUILD_SOURCEBRANCHNAME} already exist"
}
