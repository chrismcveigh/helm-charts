# PostgreSQL

[PostgreSQL](https://postgresql.org) is a powerful, open source object-relational database system. It has more than 15 years of active development and a proven architecture that has earned it a strong reputation for reliability, data integrity, and correctness.

## TL;DR;

```bash
$ helm install stable/postgresql
```

## Introduction

This chart bootstraps a [PostgreSQL](https://github.com/docker-library/postgres) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release stable/postgresql
```

The command deploys PostgreSQL on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the PostgresSQL chart and their default values.

| Parameter                  | Description                                | Default                                                    |
| -----------------------    | ----------------------------------         | ---------------------------------------------------------- |
| `image`                    | `postgres` image repository                | `postgres`                                                 |
| `imageTag`                 | `postgres` image tag                       | `9.5.4`                                                    |
| `imagePullPolicy`          | Image pull policy                          | `Always` if `imageTag` is `latest`, else `IfNotPresent`    |
| `postgresUser`             | Username of new user to create.            | `postgres`                                                 |
| `postgresPassword`         | Password for the new user.                 | none (must be supplied)                                    |
| `postgresDatabase`         | Name for new database to create.           | `postgres`                                                 |
| `persistence.enabled`      | Use a PVC to persist data                  | `true`                                                     |
| `persistence.storageClass` | Storage class of backing PVC               | `generic`                                                  |
| `persistence.accessMode`   | Use volume as ReadOnly or ReadWrite        | `ReadWriteMany`                                            |
| `persistence.size`         | Size of data volume                        | `10Gi`                                                     |
| `persistence.existingClaim`| Re-Use existing PVC                        |                                                            |
| `resources`                | CPU/Memory resource requests/limits        | Memory: `256Mi`, CPU: `100m`                               |
| `shared_buffers`           | Dedicated memory for caching               | `128MB`                                                    |
| `temp_buffers`             | Per Connection memory for temp buffers     | `8MB`                                                      |
| `work_mem`                 | Working memory for sorts/joins             | `4MB`                                                      |
| `maintenance_work_mem`     | Max mem for maint ops (VACCUM/ALTER TABLE) | `64MB`                                                     |
| `max_stack_depth`          | Max safe execution depth of servers stack  | `2MB`                                                      |
| `random_page_cost`         | Est of the cost of a non-seq disk page     | `1.1`                                                      |
| `effective_cache_size`     | Planner Est Cache size available per query | `4GB`                                                      |
| `track_activity_query_size`| Bytes reserved for pg_stat_activity.query  | `1024`                                                     |
| `autovacuum_vacuum_scale_factor`| Fract of table size before vacuum     | `0.2`                                                      |
| `autovacuum_analyze_scale_factor`| Fract of table size before analyze   | `0.1`                                                      |

The above parameters map to the env variables defined in [postgres](http://github.com/docker-library/postgres). For more information please refer to the [postgres](http://github.com/docker-library/postgres) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set postgresUser=my-user,postgresPassword=secretpassword,postgresDatabase=my-database \
    stable/postgresql
```

The above command creates a PostgresSQL user named `root` with password `secretpassword`. Additionally it creates a database named `my-database`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml stable/postgresql
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [postgres](https://github.com/docker-library/postgres) image stores the PostgreSQL data and configurations at the `/var/lib/postgresql/data/pgdata` path of the container.

The chart mounts a [Persistent Volume](http://kubernetes.io/docs/user-guide/persistent-volumes/) volume at this location. The volume is created using dynamic volume provisioning.

## Pipeline

To centralize postgres operations and make deployments easier, the [postgres pipeline](https://ci.global.cloud.sap/teams/main/pipelines/postgres) can be used across the core CCloud Openstack services. This pipeline picks up commits from `common/postgresql` chart and automatically triggers a helm-diff. 
