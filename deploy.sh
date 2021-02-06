#!/bin/bash

aws ecr describe-repositories --repository-names $CIRCLE_PROJECT_REPONAME || aws ecr create-repository --repository-name $CIRCLE_PROJECT_REPONAME
ecs-cli configure profile --profile-name $profile --access-key $accesskey --secret-key $secretkey
ecs-cli configure --cluster $cluster_name --default-launch-type $launch_type --region $region --config-name $config_name 
ecs-cli compose up  --cluster-config $config_name --ecs-profile $profile 


