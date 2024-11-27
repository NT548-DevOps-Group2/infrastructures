## Configuration (Operator)
```
helm repo add datadog https://helm.datadoghq.com

kubectl create ns datadog

helm install datadog-operator datadog/datadog-operator -n datadog

kubectl create secret generic datadog-secret --from-literal api-key=<API_KEY> -n datadog

kubectl apply -f datadog-agent.yaml -n datadog
```

## Install Location worker
```
helm repo add datadog https://helm.datadoghq.com

helm repo update

helm install location-worker datadog/synthetics-private-location --set-file configFile=synthetic-test/location-worker.json -n app
```