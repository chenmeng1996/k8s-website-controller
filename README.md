# k8s-website-controller
A barely working example of a Kubernetes controller, which watches the Kubernetes API server for `website` objects and runs an Nginx webserver for each of them. 

NOTE: This is not the correct way to create a Kubernetes controller, as it simply performs a watch request in a loop. This will never work properly, because some watch events will be lost. 

# 测试
创建自定义资源类型：websites
```
kubectl create -f website-crd.yaml
```

本机8001端口 代理 k8s apiServer服务
```
kubectl proxy --port=8001
```

启动website-controller程序，通过轮询apiServe来监听websites资源
```
go run pkg/website-controller.go
```

尝试创建一个websites资源
```
kubectl create -f kubia-website.yaml
```

website-controller程序监听到websites资源的创建，分别通过deployment-template.json和
service-template.json配置文件创建deployment和service资源。
deployment-template.json在一个pod中创建两个容器，一个容器是nginx，作为web服务器。
另一个容器用来同步指定的git仓库到pod中，作为web静态资源。

查看service的随机端口号:
```
kubectl get services
```

访问：
```
curl http://localhost:端口号
```