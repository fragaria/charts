# Adventura stack admin (Zanet)

## Introduction

This chart bootstraps an admin deployment from adventura stack on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.6+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure
- Added Fragaria Helm repository

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release adv-zanet \
    --set ingress.enabled="true",ingress.hosts[0].name=default,ingress.hosts[0].host=advtest.local \
    --set configMapName=advconfig \
    --set secretName=advsecret \
    --set settingsModule=adv.sites.adv
```

The command deploys adv website on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

As you can see, config map with shared adv config and secret with sensitive data has to be provided upfront. Adv deployment expects to find following keys:

### ConfigMap

| Variable                          | Description                                                                           | Default                                       |
| --------------------------------- | ------------------------------------------------------------------------------------- | --------------------------------------------- |
| `ADV_CLM_API_ADV_HOST`            | (Required) Hostname of ADV colombo server.                                            | `nil`                                         |
| `ADV_CLM_API_CHT_HOST`            | (Required) Hostname of CHT colombo server.                                            | `nil`                                         |
| `ADV_DEFAULT_FROM_EMAIL`          | (Required) Default sender email address.                                              | `nil`                                         |
| `ELASTICSEARCH_HOST`              | (Required) Hostname of ElasticSearch server.                                          | `nil`                                         |
| `DB_HOST`                         | (Required) Hostname of PostgreSQL server.                                             | `nil`                                         |
| `DB_NAME`                         | (Required) Name of PostgreSQL database to use.                                        | `nil`                                         |
| `DB_USER`                         | (Required) Name of PostgreSQL user to use.                                            | `nil`                                         |
| `REDIS_HOST`                      | (Required) Hostname of Redis server.                                                  | `nil`                                         |
| `ADV_AWS_STORAGE_BUCKET_NAME`     | S3 storage bucket name.                                                               | `adventura-cz-dev`                            |
| `ADV_AWS_ENABLED`                 | Enable AWS S3 storage support?                                                        | `false`                                       |
| `ADV_AWS_S3_HOST`                 | AWS S3 host endpoint.                                                                 | `s3-eu-west-1.amazonaws.com`                  |
| `ADV_AWS_S3_URL_PROTOCOL`         | Which protocol to use.                                                                | `https:`                                      |
| `ADV_DISQUS_WEBSITE_SHORTNAME`    | Disqus website shortname (used for CHT).                                              | `wwwchinatourscz`                             |
| `ADV_REDIS_CONSTANCE_DB`          | Redis DB number for Django constance storage.                                         | `1`                                           |
| `ADV_REDIS_CELERYRESULTBACKEND_DB`| Redis DB number for celery results backend.                                           | `2`                                           |
| `ADV_REDIS_CELERYBROKER_DB`       | Redis DB number for celery beat broker.                                               | `3`                                           |
| `ADV_REDIS_CACHE_DB`              | Redis DB number for app caches.                                                       | `15`                                          |

### Secret

All keys are **required**.

| Variable                          | Description                                                                           |
| --------------------------------- | ------------------------------------------------------------------------------------- |
| `ADV_AWS_ACCESS_KEY_ID`           | AWS access key id.                                                                    |
| `ADV_AWS_SECRET_ACCESS_KEY`       | AWS secret access key.                                                                |
| `ADV_CLM_API_ADV_SECRET`          | Secret for ADV colombo server.                                                        |
| `ADV_CLM_API_CHT_SECRET`          | Secret for CHT colombo server.                                                        |
| `ADV_DISQUS_API_KEY`              | Disqus api key.                                                                       |
| `ADV_DISQUS_API_SECRET`           | Disqus api secret.                                                                    |
| `ADV_POSTAGEAPP_APIKEY`           | Postage App API key.                                                                  |
| `ADV_SECRET`                      | Django Secret key.                                                                    |
| `ADV_WEB_API_SALT`                | Web api sign salt.                                                                    |
| `DB_PASSWORD`                     | Password for PostgreSQL database.                                                     |

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

| Parameter                                    | Description                                                                                  | Default                                              |
| -------------------------------------------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `settingsModule`                             | (Required) Django settings module.                                                           | `adv.sites.advweb`                                   |
| `configMapName`                              | (Required) Name of the shared config map.                                                    | `nil`                                                |
| `secretName`                                 | (Required) Name of the shared secret.                                                        | `nil`                                                |
| `debugMode`                                  | Run in debug mode?                                                                           | `false`                                              |
| `mainWorkers`                                | How many gunicorn workers of the main process to spawn?                                      | `1`                                                  |
| `mainReplicaCount`                           | How many replicas to create for the main process?                                            | `1`                                                  |
| `uploadWorkers`                              | How many gunicorn workers of the upload process to spawn?                                    | `1`                                                  |
| `uploadReplicaCount`                         | How many replicas to create for the upload process?                                          | `1`                                                  |
| `managers`                                   | Emails to managers.                                                                          | `[['admin', 'admin@fragaria.cz']]`                   |
| `constance.backend`                          | Backend to use for Django constance.                                                         | `constance.backends.redisd.RedisBackend`             |
| `ingress.enabled`                            | Prepare ingress for the service?                                                             | `false`                                              |
| `ingress.hosts[0].name`                      | Name of the ingress host (there can be multiple). Usually, you would se this to `default`.   | `nil`                                                |
| `ingress.hosts[0].host`                      | Hostname to serve the app on.                                                                | `nil`                                                |
| `ingress.createTls`                          | Create TLS?                                                                                  | `nil`                                                |
| `sentry.dsn`                                 | Sentry DSN url, enables Sentry logging when set.                                             | `nil`                                                |
| `service.type`                               | Kubernetes service type.                                                                     | `ClusterIP`                                          |
| `service.port`                               | Port of the ADV container.                                                                   | `8000`                                               |
| `image.tag`                                  | `adv` image tag.                                                                             | `0.1.2`                                              |
| `image.repository`                           | `adv` image repository                                                                       | `registry.rancher.f-app.it/adv`                |
| `image.pullPolicy`                           | `adv` image pull policy                                                                      | `IfNotPresent`                                       |
| `image.pullSecretName`                       | `adv` image secret to use when pulling the image, required for registry authentication       | `regcred`                                            |
| `nodeSelector`                               | Node labels for pod assignment                                                               | {}                                                   |
| `resources`                                  | CPU/Memory resource requests/limits                                                          | Memory: `256Mi`, CPU: `100m`                         |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
    --set ingress.enabled="true",ingress.hosts[0].name=default,ingress.hosts[0].host=advtest.local
    boris
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml adv-zanet
```

> **Tip**: You can use the default [values.yaml](values.yaml)

