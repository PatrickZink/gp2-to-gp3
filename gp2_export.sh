#!/bin/bash

# This script searches for all GP2 EBS volumes in your AWS account and outputs the corresponding GP3 volumes with comparable IOPS and Throughput. 
# The output is in CSV format with a semicolon as the delimiter.

# Set the name of the output CSV file
output_csv="gp2_to_gp3_volumes.csv"

# Use a semicolon as the delimiter for compatibility with European Excel versions
delimiter=";"

# Write the header to the CSV file
echo "VolumeId${delimiter}Size(GB)${delimiter}IOPS${delimiter}Throughput (MB/s)" > "$output_csv"

# Retrieve all EBS volumes of type 'gp2' and write the results to a temporary file
aws ec2 describe-volumes --query 'Volumes[?VolumeType==`gp2`].[VolumeId,Size,Iops]' --output text | while read -r volume_id size iops; do

  # Set standard IOPS and throughput for GP3
  gp3_base_iops=3000
  gp3_base_throughput=125
  gp3_max_iops=16000
  gp3_max_throughput=250

  # Calculate IOPS for GP2 based on size: 3 IOPS per GiB
  new_iops=$(($size * 3))

  # Limit the IOPS to the maximum of 16,000 for GP3
  if [[ $new_iops -gt $gp3_max_iops ]]; then
    new_iops=$gp3_max_iops
  elif [[ $new_iops -lt $gp3_base_iops ]]; then
    # If the calculated IOPS are below the base value of 3,000, use the base value
    new_iops=$gp3_base_iops
  fi

  # Throughput for GP2 Volumes larger than or equal to 334 GiB deliver 250 MiB/s
  new_throughput=$gp3_base_throughput
  if [[ $size -ge 334  ]]; then
    new_throughput=250 
  fi

  # Write the results to the CSV file
  echo "$volume_id${delimiter}$size${delimiter}$new_iops${delimiter}$new_throughput" >> "$output_csv"
done

# Output the created CSV file
echo "Results have been written to the file $output_csv"