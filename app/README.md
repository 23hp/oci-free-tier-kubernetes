# Set up an application in k8s

## Install Gateway API CRDs

Check latest version [here](https://gateway-api.sigs.k8s.io/v1alpha2/guides/#install-standard-channel)
 
``` bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.8.1/standard-install.yaml
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

# Enable istio-injection 
kubectl label namespace default istio-injection=enabled
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
helm ls -n istio-system
kubectl label namespace default istio-injection-
helm delete istiod -n istio-system
helm delete istio-base -n istio-system
kubectl delete namespace istio-system
kubectl get crd -oname | grep --color=never 'istio.io' | xargs kubectl delete
# Remove Gateway API CRDs
kubectl delete -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.8.1/standard-install.yaml
``` 


