#Upload all Files to Blob Storage in a Container
azcopy /Source:"E:\TestdataTree" /Dest:https://<yourAzStorageAccount>.blob.core.windows.net/copydata /DestKey:<yourkey> /S

#Upload blob with specific pattern
AzCopy /Source:C:\01 /Dest:https://<yourAzStorageAccount>.blob.core.windows.net/sample /DestKey:<yourkey> /Pattern:"01.txt"

#Upload blob to virtual Directory
AzCopy /Source:C:\myfolder /Dest:https://myaccount.blob.core.windows.net/mycontainer/vd /DestKey:key /Pattern:abc.txt

#Download Files to local drive from Blob container
AzCopy /Source:https://<yourAzStorageAccount>.blob.core.windows.net/sample /DestKey:<yourkey> /Dest:C:\myfolder /SourceKey:<yourkey> /S

#Copy a single blob from one container to another within same storage account
AzCopy /Source:https://myaccount.blob.core.windows.net/mycontainer1 /Dest:https://myaccount.blob.core.windows.net/mycontainer2 /SourceKey:key /DestKey:key /Pattern:abc.txt

#Copy a single blob from one storage account to another
AzCopy /Source:https://sourceaccount.blob.core.windows.net/mycontainer1 /Dest:https://destaccount.blob.core.windows.net/mycontainer2 /SourceKey:key1 /DestKey:key2 /Pattern:abc.txt

#Copy all blob from one container of a storage account to another 
AzCopy /Source:https://sourceaccount.blob.core.windows.net/mycontainer1 
/Dest:https://destaccount.blob.core.windows.net/mycontainer2 /SourceKey:key1 /DestKey:key2 /S

#Download a single file
AzCopy /Source:https://myaccount.file.core.windows.net/myfileshare/myfolder1/ /Dest:C:\myfolder /SourceKey:key /Pattern:abc.txt

#Download All files
AzCopy /Source:https://myaccount.file.core.windows.net/myfileshare/ /Dest:C:\myfolder /SourceKey:key /S