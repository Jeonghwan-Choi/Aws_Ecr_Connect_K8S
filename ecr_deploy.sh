
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin {aws}.dkr.ecr.ap-northeast-2.amazonaws.com

docker build -t app-v1 .

docker tag app-v1:latest {aws}.dkr.ecr.ap-northeast-2.amazonaws.com/app-v1:latest

docker push {aws}.dkr.ecr.ap-northeast-2.amazonaws.com/app-v1:latest
