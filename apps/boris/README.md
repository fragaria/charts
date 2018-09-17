# BorIS

[BorIS](https://bor-is.cz) is management app for social workers.

## Introduction

This chart bootstraps a BorIS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.6+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure
- Added Fragaria Helm repository

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release boris \
    --set ingress.enabled="true",ingress.hosts[0].name=default,ingress.hosts[0].host=boristest.local \
    --set service.type=NodePort \
    --set mysql.mysqlPassword="borisuserpassword",mysql.mysqlRootPassword="mysqlrootpassword" \
    --set borisCreateSuperUser="true",borisSuperUserUsername="yourusername",borisSuperUserEmail="your@email.com",borisSuperUserPassword="yourpassword"
```

The command deploys BorIS on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

Make sure to provide both root password and user password for *MySQL* to avoid problems during app updates. You won't need to rember it, just generate a random one.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the MySQL chart and their default values.

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `borisPort`                                  | Port of the BorIS container                                                                  | `80`                                                 |
| `borisDebug`                                 | Run BorIS in debug mode?                                                                     | `false`                                              |
| `borisAdminEmail`                            | Administrator email                                                                          | admin@fragaria.cz                                    |
| `borisWorkers`                               | How many gunicorn workers to spawn?                                                          | `1`                                                  |
| `borisAllowedHosts`                          | Which hosts are OK? (this should be kept to defaults unless sure)                            | `*`                                                  |
| `borisSecretKey`                             | Secret key to use. Random value will be generated if not specified.                          | `nil`                                                |
| `borisCreateSuperUser`                       | Create superuser? Will be only done when installing, not during upgrades.                    | `false`                                              |
| `borisSuperUserUsername`                     | Username for superuser.                                                                      | `nil`                                                |
| `borisSuperUserEmail`                        | Email of the superuser.                                                                      | `nil`                                                |
| `borisSuperUserPassword`                     | Password of the superuser.                                                                   | `nil`                                                |
| `ingress.enabled`                            | Prepare ingress for the service?                                                             | `false`                                              |
| `ingress.hosts[0].name`                      | Name of the ingress host (there can be multiple). Usually, you would se this to `default`.   | `nil`                                                |
| `ingress.hosts[0].host`                      | Hostname to serve BorIS on.                                                                  | `nil`                                                |
| `service.type`                               | Kubernetes service type.                                                                     | `ClusterIP`                                          |
| `image.tag`                                  | `boris` image tag.                                                                           | `0.3.0`                                              |
| `image.repository`                           | `boris` image repository                                                                     | `registry.rancher.f-app.it/boris`                    |
| `image.pullPolicy`                           | `boris` image pull policy                                                                    | `IfNotPresent`                                       |
| `image.pullSecretName`                       | `boris` image secret to use when pulling the image, required for registry authentication     | `regcred`                                            |
| `mysql.mysqlUser`                            | Username of DB user to create.                                                               | `boris`                                              |
| `mysql.mysqlPassword`                        | Password of DB user.                                                                         | random string                                        |
| `mysql.mysqlRootPassword`                    | Password of root DB user.                                                                    | random string                                        |
| `mysql.mysqlDatabase`                        | DB name to create.                                                                           | `boris`                                              |
| `nodeSelector`                               | Node labels for pod assignment                                                               | {}                                                   |
| `resources`                                  | CPU/Memory resource requests/limits                                                          | Memory: `256Mi`, CPU: `100m`                         |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
    --set ingress.enabled="true",ingress.hosts[0].name=default,ingress.hosts[0].host=boristest.local
    boris
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml boris
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

TODO

