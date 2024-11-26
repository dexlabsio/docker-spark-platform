# How to deploy this spark distribution on kubernetes

## Requirements

* Kubernetes >= 1.31
* Helm >= 3.16

## Step-by-step

- Apply namespace manifest
- Install stackgres operator
- Create postgres cluster using stackgres
- Apply migrations
- Create minio instance using minio-operator
- Create a bucket within this minio cluster
- Create an API Key for minio access
- Redefine spark values according to your requirements
- Apply spark charts
