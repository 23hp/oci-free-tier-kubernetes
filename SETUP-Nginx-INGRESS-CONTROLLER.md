# Set up Cluster


## Install [Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/#quick-start)

``` bash
helm upgrade --install ingress-nginx ingress-nginx --repo https://kubernetes.github.io/ingress-nginx --namespace ingress-nginx --create-namespace \
   --set controller.service.annotations.service\\.beta\\.kubernetes\\.io/oci-load-balancer-shape=flexible \
   --set controller.service.annotations.service\\.beta\\.kubernetes\\.io/oci-load-balancer-shape-flex-min=10 \
   --set controller.service.annotations.service\\.beta\\.kubernetes\\.io/oci-load-balancer-shape-flex-max=10

```

## (OPTIONAL) Create Sample App

``` bash
kubectl apply -f k8s-learning/deployment.yaml -f k8s-learning/service.yaml -f k8s-learning/ingress.yaml
```

## Clean
``` bash
kubectl delete -f k8s-learning/deployment.yaml -f k8s-learning/service.yaml -f k8s-learning/ingress.yaml
helm uninstall ingress-nginx  -n ingress-nginx
kubectl delete ns ingress-nginx 
```

helm install v0.67.1 prometheus-community/kube-prometheus-stack