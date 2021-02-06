#!/bin/bash

echo -e  "Deploy To ECS\n...........................\n"
read -t 20 -p 'Do you have ECS config Profile (yes/no) ' answer
if [ $answer == no ]
then 
clear
echo -e "Fill the upcoming params to setup your ECS Config profile:\n"
read -t 20 -p 'Profile: ' profile
read -t 20 -sp 'AccessKey: ' accesskey
echo""
read -t 20 -sp 'SecretKey: ' secretkey
ecs-cli configure profile --profile-name $profile --access-key $accesskey --secret-key $secretkey
clear
echo -e  "Build the image\n"
read -t 20 -p 'image_name: ' image_name
read -t 20 -p 'aws_account_id: ' aws_account_id
read -t 20 -p 'Region: ' region 
IMAGE=$aws_account_id/$image_name
aws configure set aws_access_key_id $accesskey
aws configure set aws_secret_access_key $secretkey
eval $(aws ecr get-login --no-include-email --region $region | sed 's;https://;;g')
cd ..
docker build -t $IMAGE .
aws ecr describe-repositories --repository-names $image_name || aws ecr create-repository --repository-name $image_name
docker push $IMAGE 
clear
echo -e  "Fill the upcoming params to setup your ECS Cluster:\n"
read -t 20 -p 'Cluster_Name: ' cluster_name
read -t 20 -p 'Launch_Type (EC2,fargate): ' launch_type
read -t 20 -p 'Region: ' region 
read -t 20 -p 'Config_Name: ' config_name
ecs-cli configure --cluster $cluster_name --default-launch-type $launch_type --region $region --config-name $config_name
echo -e "Create Task and Run it\n"
ecs-cli compose up  --cluster-config $config_name --ecs-profile $profile
else
clear
echo -e  "Build the image\n"
read -t 20 -p 'image_name: ' image_name
read -t 20 -sp 'aws_account_id: ' aws_account_id
read -t 20 -sp 'AccessKey: ' accesskey
echo""
read -t 20 -sp 'SecretKey: ' secretkey
read -t 20 -p 'Region: ' region 
IMAGE=$aws_account_id/$image_name
aws configure set aws_access_key_id $accesskey
aws configure set aws_secret_access_key $secretkey
eval $(aws ecr get-login --no-include-email --region $region | sed 's;https://;;g')
cd ..
docker build -t $IMAGE .
aws ecr describe-repositories --repository-names $image_name || aws ecr create-repository --repository-name $image_name
docker push $IMAGE 
clear
echo -e  "Fill the upcoming params to setup your ECS Cluster:\n"
read -t 20 -p 'Cluster_Name: ' cluster_name
read -t 20 -p 'Launch_Type (EC2,fargate): ' launch_type
#read -t 20 -p 'Region: ' region 
read -t 20 -p 'Config_Name: ' config_name
read -t 20 -p 'Profile: ' profile
ecs-cli configure --cluster $cluster_name --default-launch-type $launch_type --region $region --config-name $config_name
echo -e "Create Task and Run it\n"
ecs-cli compose up  --cluster-config $config_name --ecs-profile $profile
ecs-cli ps --cluster-config $config_name --ecs-profile $profile
fi
