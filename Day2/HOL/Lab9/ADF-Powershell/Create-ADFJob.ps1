#Connect Azure connect
Connect-AzAccount

#Get Azure Subscription
Get-AzSubscription

#Select Azure subscription
Select-AzSubscription -SubscriptionId "<SubscriptionId>"

#Provide Resource Group
$resourceGroupName = "ADFQuickStartRG";

#Provide location of ADF
$ResGrp = New-AzResourceGroup $resourceGroupName -location 'East US'

#Name ADF job
$dataFactoryName = "ADFQuickStartFactory";

#Create ADF v2 job
$DataFactory = Set-AzDataFactoryV2 -ResourceGroupName $ResGrp.ResourceGroupName `
    -Location $ResGrp.Location -Name $dataFactoryName

    #Set location of Linked Service
    Set-Location 'C:\ADFv2QuickStartPSH'

    #Create Azure Storage Linked service

    Set-AzDataFactoryV2LinkedService -DataFactoryName $DataFactory.DataFactoryName `
    -ResourceGroupName $ResGrp.ResourceGroupName -Name "AzureStorageLinkedService" `
    -DefinitionFile ".\AzureStorageLinkedService.json"

    #Create a Dataset
    Set-AzDataFactoryV2Dataset -DataFactoryName $DataFactory.DataFactoryName `
    -ResourceGroupName $ResGrp.ResourceGroupName -Name "BlobDataset" `
    -DefinitionFile ".\BlobDataset.json"

    #Create a Pipeline

    $DFPipeLine = Set-AzDataFactoryV2Pipeline `
    -DataFactoryName $DataFactory.DataFactoryName `
    -ResourceGroupName $ResGrp.ResourceGroupName `
    -Name "Adfv2QuickStartPipeline" `
    -DefinitionFile ".\Adfv2QuickStartPipeline.json"

    #Run the Pipeline
    $RunId = Invoke-AzDataFactoryV2Pipeline `
    -DataFactoryName $DataFactory.DataFactoryName `
    -ResourceGroupName $ResGrp.ResourceGroupName `
    -PipelineName $DFPipeLine.Name `
    -ParameterFile .\PipelineParameters.json

    #Monitor the ADF pipeline run
    while ($True) {
    $Run = Get-AzDataFactoryV2PipelineRun `
        -ResourceGroupName $ResGrp.ResourceGroupName `
        -DataFactoryName $DataFactory.DataFactoryName `
        -PipelineRunId $RunId

    if ($Run) {
        if ($run.Status -ne 'InProgress') {
            Write-Output ("Pipeline run finished. The status is: " +  $Run.Status)
            $Run
            break
        }
        Write-Output "Pipeline is running...status: InProgress"
    }

    Start-Sleep -Seconds 10
}