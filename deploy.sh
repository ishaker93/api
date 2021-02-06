#!/bin/bash

ecs-cli configure profile --profile-name $profile --access-key $accesskey --secret-key $secretkey
ecs-cli configure --cluster $cluster_name --default-launch-type $launch_type --region $region --config-name $config_name 
ecs-cli compose up  --cluster-config $config_name --ecs-profile $profile 


