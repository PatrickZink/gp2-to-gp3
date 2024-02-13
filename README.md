# gp2-to-gp3

## Step 1: Check if GP2 EBS volumes are in use and calculate the costs
To determine if any GP2 EBS volumes are actively being used, you can apply a filter in the EC2 -> Volumes section by setting "Type = gp2".

Should GP2 EBS volumes be there, you can upload the script ```gp2_export.sh``` to the AWS CloudShell. 

Run ```chmod 755 gp2_export.sh``` in the AWS CloudShell

Run ```./gp2_export.sh``` in the AWS CloudShell

Download from AWS CloudShell the ```gp2_to_gp3_volumes.csv``` File

Check the script's output and adjust the IOPS and Throughput if needed. The script sets these to match GP2 performance. If you don't need more than the GP3 baseline of 3000 IOPS and 125 MiB/s Throughput, you can lower the values to save costs.

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/9993f9e2-ddf0-4234-9bc8-bf3675777a99)

These figures can be input into the AWS Calculator using the [Bulk Import](https://calculator.aws/#/bulk-import) feature to estimate the costs related to the GP2 EBS volumes. This lets you easily compare costs between GP2 and GP3 volumes and see how much you could save by migrating from GP2 to GP3.

Fill out the Excel spreadsheet with the command's output:

[Amazon_Elastic_Block_Store_EBS_BulkUpload_Template_Commercial.xlsx](https://github.com/PatrickZink/gp2-to-gp3/files/14241218/Amazon_Elastic_Block_Store_EBS_BulkUpload_Template_Commercial.xlsx)

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/beb10619-a051-40ef-87f1-7aa613138ddd)


In this example, we have current GP2 EBS costs of $559.42 USD.

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/04cf99aa-f230-4403-b600-fa9e4f03a120)
![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/949b04e0-f28b-49ae-8b41-a8497f63e301)

You can now enter the GP3 values and re-evaluate the costs:

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/87488247-f5f8-4850-b35f-0c4d80c85b18)
![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/a3ceff97-fbef-4adf-bacd-f6cb4b117bb2)

In this example, the GP3 costs amount to $502.29 USD, resulting in a saving of $57.13 USD, which is a reduction of approximately 10.21%.



## Step 2: Migrate the GP2 to GP3 Volumens

Upload the script ```gp2-gp3-migration.sh``` to the AWS CloudShell. 

Run ```chmod 755 gp2-gp3-migration.sh``` in the AWS CloudShell

Run ```./gp2-gp3-migration.sh``` in the AWS CloudShell

Please double-check the output; this will now migrate your GP2 volumes to GP3 based on the CSV values for IOPS and Throughput.

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/37870de6-ea77-47a9-b84a-e66383157bee)

If you are ready to migrate the volumes from GP2 to GP3, run:

```./gp2-gp3-migration.sh no-dry-run``` 

This will now migrate the EBS Volume from GP2 to GP3:

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/45236014-8648-4e51-92c5-15457566e578)

You can check the progess in the AWS Console EC2 -> Volumes section:
![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/137aec09-8dbc-49a7-9b9a-d9d1942a48a7)






