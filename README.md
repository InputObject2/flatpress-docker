# Flatpress Helm Chart

This Helm chart deploys the Flatpress web application in Kubernetes.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+

## Installing the Chart

To install the chart from a Helm repository, add the repository to your Helm installation:

```bash
helm repo add charts.example.com https://charts.example.com
```

Then, to install the chart with the release name flatpress, use the following command:

```bash
helm install flatpress charts.example.com/flatpress
```

This will create a Deployment and a Service to expose the Flatpress application, as well as a PersistentVolumeClaim to persist the fp-content data.

## Configuration

The following table lists the configurable parameters of the Flatpress chart and their default values.

| Parameter                               | Description                                            | Default                                      |
| --------------------------------------- | ------------------------------------------------------ | -------------------------------------------- |
| `deployment.name`                       | Deployment name                                        | `flatpress`                                  |
| `deployment.replicas`                   | Number of replicas                                     | `3`                                          |
| `deployment.annotations`                | Deployment annotations                                 | `{}`                                         |
| `deployment.labels`                     | Deployment labels                                      | `{ app: flatpress }`                         |
| `deployment.podAnnotations`             | Pod annotations                                        | `{}`                                         |
| `deployment.tolerations`                | Pod tolerations                                        | `[]`                                         |
| `deployment.image`                      | Docker image for the Flatpress application              | `example/flatpress:latest`                  |
| `ingress.enabled`                       | Enable Ingress resource                                | `false`                                      |
| `ingress.hostname`                      | Hostname for the Ingress resource                      | `flatpress.example.com`                     |
| `ingress.annotations`                   | Ingress annotations                                    | `{}`                                         |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example, to specify the number of replicas and the hostname for the Ingress resource:

```bash
helm install flatpress charts.example.com/flatpress --set deployment.replicas=5,ingress.hostname=flatpress.mydomain.com
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example:

```bash
helm install flatpress charts.example.com/flatpress -f values.yaml
```

## Docker Image
The Docker image for the Flatpress application is built from the Dockerfile included in this repository. The image is built in multiple stages to minimize the size of the final image.

To build the image, run the following command from the root of the repository:

```bash
docker build -t example/flatpress:latest .
```

This will build the Docker image and tag it as example/flatpress:latest.

## Upgrading
To upgrade the chart, use the helm upgrade command:

```bash
helm upgrade flatpress charts.example.com/flatpress
```

## Uninstalling

To uninstall the chart, use the `helm uninstall` command:

```bash
helm uninstall flatpress
```

This will delete the Deployment, Service, and PersistentVolumeClaim resources created by the chart. It will not delete the Docker image or the data in the fp-content volume.