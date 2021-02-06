# api

#Front

★ Build and Deploy from your laptop:
1. Pull The Repo.
2. open local file.
3. change the image name at docker-compose to match your aws_account-id. 
4. run the deploy.sh to build, push the image to ECR, create the task definition and run it. 

★ Build and Deploy using circleci config file:
1. Pull The Repo.
2. change the image name at docker-compose to match your aws_account-id. 
2. Add the variables to circleci " prefered to add it as a context "
3. push your changes then the deploy.sh script will Build, push the image to ECR, create the task definition and run it.
