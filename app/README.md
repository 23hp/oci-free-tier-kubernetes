# Set up an application in k8s

## Install [Istio](https://istio.io/latest/docs/ambient/getting-started/)
``` bash
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.23.0
export PATH=$PWD/bin:$PATH
```

## Install Gateway API CRDs

Check [latest version](https://gateway-api.sigs.k8s.io/guides/#installing-gateway-api)
 
``` bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml; }
```


## Install Istio using the ambient profile
``` bash
istioctl install --set profile=ambient --skip-confirmation

``` 

## Deploy the app
``` bash
# Making sure we are in the right folders
cd app
# Deploy your app
kubectl apply -f deployment.yaml -f service.yaml

# Expose the app
kubectl create namespace ingress
kubectl apply -f gateway.yaml -f httproute.yaml
``` 
## Access the App
``` bash
# Find Public IP of the gateway
kubectl get service -n ingress
export INGRESS_HOST=$(kubectl -n ingress get service gateway-example-istio -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $INGRESS_HOST
```
## Cleaning
``` bash
# Remove app
kubectl delete -f gateway.yaml -f httproute.yaml -f deployment.yaml -f service.yaml
kubectl delete namespace ingress
# Remove istio
istioctl uninstall --purge -y
kubectl delete namespace istio-system
# Remove Gateway API CRDs
kubectl delete -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml
``` 


