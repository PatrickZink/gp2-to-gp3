#!/bin/bash

# This script reads a CSV file with EBS volume configurations and updates those volumes to GP3.
# By default, this script performs a 'dry run'. To actually apply the changes, run this script with 'no-dry-run' argument.

# Set the name of the input CSV file
input_csv="gp2_to_gp3_volumes.csv"

# Use a semicolon as the delimiter
delimiter=";"

# Check for 'no-dry-run' argument to determine if changes should be applied
if [ "$1" == "no-dry-run" ]; then
  dry_run_option=""
else
  dry_run_option="--dry-run"
fi

echo "Starting EBS volume modification process..."

# Skip the header line and read the rest of the CSV
tail -n +2 "$input_csv" | while IFS="$delimiter" read -r volume_id size iops throughput; do
  # Attempt to modify the EBS volume to GP3 with the specified IOPS and Throughput
  modify_output=$(aws ec2 modify-volume --volume-id "$volume_id" --volume-type gp3 --iops "$iops" --throughput "$throughput" $dry_run_option 2>&1)
  modify_exit_code=$?
  
  # Check exit status of the AWS CLI command
  if [ $modify_exit_code -eq 0 ]; then
    echo "Modification initiated for volume $volume_id with Size ${size}GiB, IOPS $iops, Throughput ${throughput}MiB/s"
  elif [[ $modify_output == *"DryRunOperation"* ]]; then
    echo "Dry run: Volume $volume_id would be modified to GP3 with Size ${size}GiB, IOPS $iops, Throughput ${throughput}MiB/s"
  else
    echo "Failed to modify $volume_id: $modify_output" >&2
  fi
done

echo "EBS volume modification script completed."