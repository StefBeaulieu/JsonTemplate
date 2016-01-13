param([string]$myJson,[string]$myJsonParam,[string]$myInputFile,[string]$RGName)
copy-item $myJsonParam "c:\script\updatedJsonParam.json"
$myJsonParam = "c:\script\updatedJsonParam.json"
$myArrayParam = import-csv $myInputFile

foreach($myValue in $myArrayParam) {
    (get-content $myJsonParam) |foreach-object {$_ -replace $myValue.Parameter,$myValue.Value} | set-content $myJsonParam
}
$RGName
$myJson
$myJsonParam

New-AzureRmResourceGroupDeployment -ResourceGroupName $RGName `
                                    -TemplateFile $myJson `
                                    -TemplateParameterFile $myJsonParam
                                    
                                    
