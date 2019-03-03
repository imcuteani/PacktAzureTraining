6.	# Log in to Azure
7.	Login-AzureRmAccount
8.	
9.	$adla = "<name of your ADLA account>"
10.	$adls = "<name of your Data Lake Store>"
11.	$rg = "<StockMarketRG>"
12.	
13.	# Verify that the ADLA account exists
14.	Get-AdlAnalyticsAccount -ResourceGroupName $rg -Name $adla
15.	
16.	# Submit an ADLA job
17.	$scriptpath = "Your local drive\StockPriceJob.usql"
18.	$job = Submit-AdlJob -AccountName $adla –ScriptPath $scriptpath -Name "Demo"
19.	
20.	# Repeatedly view the status of the job
21.	$job = Get-AdlJob -AccountName $adla -JobId $job.JobId
22.	
23.	# Wait for the job to complete
24.	Wait-AdlJob -Account $adla -JobId $job.JobId
25.	
26.	# Download the results
Export-AdlStoreItem -AccountName $adls -Path "/output/MaxPrices.csv" -Destination "Your local drive\MaxPrices.csv"
