## FlaskAppContainer
Build and run your generic container locally:
```
docker build -t flask-app-container:latest .
docker run -it -p 8080:8000 flask-app-container:latest
```

Now [view the app](http://localhost:8080)!


## FlaskLambdaContainer
Build and run in Lambda execution environment:
```
docker build -t flask-lambda-container:latest .

docker tag flask-lambda-container:latest 397329935272.dkr.ecr.us-east-1.amazonaws.com/flask-lambda-container:latest

aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin 397329935272.dkr.ecr.us-east-1.amazonaws.com

aws ecr create-repository \
 --repository-name flask-lambda-container \
 --image-scanning-configuration scanOnPush=true \
 --region us-east-1

docker push 397329935272.dkr.ecr.us-east-1.amazonaws.com/flask-lambda-container:latest

aws lambda --region us-east-1 create-function \
--function-name flask-lambda-container \
--package-type Image \
--role arn:aws:iam::397329935272:role/supernova-execution-role \
--code ImageUri=397329935272.dkr.ecr.us-east-1.amazonaws.com/flask-lambda-container:latest 

aws lambda --region us-east-1 invoke \
--function-name flask-lambda-container \
--invocation-type Event \
--payload '{ "foo": "bar" }' \
outfile.txt

```

## FlaskLambdaDualDeployment
Build and run locally and in Lambda execution environment:
```
docker build -t flask-lambda-dual:latest .

docker run -it -p 8081:8000 flask-lambda-dual:latest

docker tag flask-lambda-dual:latest 397329935272.dkr.ecr.us-east-1.amazonaws.com/flask-lambda-dual:latest

aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin 397329935272.dkr.ecr.us-east-1.amazonaws.com

aws ecr create-repository \
 --repository-name flask-lambda-dual \
 --image-scanning-configuration scanOnPush=true \
 --region us-east-1

docker push 397329935272.dkr.ecr.us-east-1.amazonaws.com/flask-lambda-dual:latest

aws lambda --region us-east-1 create-function \
--function-name flask-lambda-dual \
--package-type Image \
--role arn:aws:iam::397329935272:role/supernova-execution-role \
--code ImageUri=397329935272.dkr.ecr.us-east-1.amazonaws.com/flask-lambda-dual:latest 

aws lambda --region us-east-1 invoke \
--function-name flask-lambda-dual \
--invocation-type Event \
--payload '{ "foo": "bar" }' \
outfile.txt

```
