#### clone code

```
git clone https://github.com/huyushi/python-sonarqube.git
cd python-sonarqube
```



#### run SonarQube

```
docker-compose up
```

![image-20230613145937490](static/image-20230613145937490.png)

![image-20230613145949407](static/image-20230613145949407.png)

![image-20230613150030423](static/image-20230613150030423.png)

#### build app

```
docker build -t my-app:v1.0 .
```

![image-20230613145858698](static/image-20230613145858698.png)

![image-20230613145841535](static/image-20230613145841535.png)

#### run app

```
docker run -d -p 5000:5000 --name my_app my-app:v1.0
curl http://127.0.0.1:5000
```


