# gp2-to-gp3

## Step 1: Check if GP2 EBS volumes are in use and calculate the current costs

To determine if any GP2 EBS volumes are actively being used, you can apply a filter in the EC2 -> Volumes section by setting "Type = gp2".

Should GP2 EBS volumes be detected, the corresponding gigabytes in use can be listed using this AWS CloudShell. 

```aws ec2 describe-volumes --filters Name=volume-type,Values=gp2 --query 'Volumes[*].Size' --output text | tr '\t' '\n'```

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/b52efce1-f41a-4dd2-a153-3031ca972e39)

These figures can be input into the AWS Calculator using the [Bulk Import](https://calculator.aws/#/bulk-import) feature to estimate the costs related to the GP2 EBS volumes. This lets you easily compare costs between GP2 and GP3 volumes and see how much you could save by migrating from GP2 to GP3.

Fill out the Excel spreadsheet with the command's output.:
[Amazon_Elastic_Block_Store_EBS_BulkUpload_Template_Commercial.xlsx](https://github.com/PatrickZink/gp2-to-gp3/files/14241218/Amazon_Elastic_Block_Store_EBS_BulkUpload_Template_Commercial.xlsx)
![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/107cee6f-c3b4-4cf7-acfc-7cb88e7553e8)

In this example, we have current GP2 EBS costs of $270.13.

![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/04cf99aa-f230-4403-b600-fa9e4f03a120)
![image](https://github.com/PatrickZink/gp2-to-gp3/assets/70896863/678c1ac0-5044-4759-880d-fb18072856a4)


## Step 2:


