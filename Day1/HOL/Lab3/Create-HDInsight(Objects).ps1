$additionalStorageAccountName = Read-Host -Prompt "Enter the name of the additional storage account"

# Create the additional storage account
New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName `
    -StorageAccountName $additionalStorageAccountName `
    -Location $location `
    -Type Standard_LRS

# Get the additional storage account key
$additionalStorageAccountKey = (Get-AzureRmStorageAccountKey -Name $additionalStorageAccountName -ResourceGroupName $resourceGroupName)[0].Value

# Create a new configuration for RServer cluster type
# Use -EdgeNodeSize to set the size of the edge node for RServer clusters
# if you want a specific size. Otherwise, the default size is used.
$config = New-AzureRmHDInsightClusterConfig `
    -ClusterType "RServer" `
    -EdgeNodeSize "Standard_D12_v2"

# Add RStudio to the configuration
$rserverConfig = @{"rstudio"="true"}
$config = $config | Add-AzureRmHDInsightConfigValues `
    -RServer $rserverConfig `
    -Spark2Defaults $spark2Config

# Add an additional storage account
Add-AzureRmHDInsightStorage -Config $config -StorageAccountName "$additionalStorageAccountName.blob.core.windows.net" -StorageAccountKey $additionalStorageAccountKey

# Create a new HDInsight cluster using -Config
New-AzureRmHDInsightCluster `
    -ClusterName $clusterName `
    -ResourceGroupName $resourceGroupName `
    -HttpCredential $httpCredential `
    -Location $location `
    -DefaultStorageAccountName "$defaultStorageAccountName.blob.core.windows.net" `
    -DefaultStorageAccountKey $defaultStorageAccountKey `
    -DefaultStorageContainer $defaultStorageContainerName  `
    -ClusterSizeInNodes $clusterSizeInNodes `
    -OSType $clusterOS `
    -Version $clusterVersion `
    -SshCredential $sshCredentials `