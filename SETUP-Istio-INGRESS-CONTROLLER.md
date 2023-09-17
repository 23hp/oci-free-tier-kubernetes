# Set up Cluster

## Check Check
``` bash
istioctl x precheck
```

## Install Istio via Helm
``` bash
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

# Install the Istio base chart
kubectl create namespace istio-system
helm install istio-base istio/base -n istio-system --set defaultRevision=default
helm ls -n istio-system

# Install the Istio discovery chart
helm install istiod istio/istiod -n istio-system --wait
helm ls -n istio-system

# Status check
helm status istiod -n istio-system
kubectl get deployments -n istio-system --output wide

```

Instll 
``` bash
kubectl create namespace istio-ingress
helm install istio-ingress istio/gateway -n istio-ingress --wait  --set-json 'service.annotations={"service.beta.kubernetes.io/oci-load-balancer-shape":"flexible","service.beta.kubernetes.io/oci-load-balancer-shape-flex-min":"10","service.beta.kubernetes.io/oci-load-balancer-shape-flex-max":"10"}'


kubectl label namespace default istio-injection=enabled

```


## (OPTIONAL) Create Sample App

``` bash
kubectl apply -f k8s-learning/deployment.yaml -f k8s-learning/service.yaml -f k8s-learning/ingress.yaml
```

## Clean
``` bash
kubectl delete -f k8s-learning/deployment.yaml -f k8s-learning/service.yaml -f k8s-learning/ingress.yaml
helm delete istio-ingress -n istio-ingress
kubectl delete namespace istio-ingress
helm delete istiod -n istio-system
helm delete istio-base -n istio-system
kubectl delete namespace istio-system
kubectl get crd -oname | grep --color=never 'istio.io'

kubectl label namespace default istio-injection-
```

helm install v0.67.1 prometheus-community/kube-prometheus-stack