# base-service

An opinionated Helm chart for deploying basic HTTP services

Current chart version is `0.5.0`

## Chart Requirements

| Repository                                       | Name  | Version |
| ------------------------------------------------ | ----- | ------- |
| https://kubernetes-charts.storage.googleapis.com | redis | 10.3.\* |

## Chart Values

| Key                                  | Type   | Default                                | Description |
| ------------------------------------ | ------ | -------------------------------------- | ----------- |
| config.configMap                     | list   | `[]`                                   |             |
| config.env                           | object | `{}`                                   |             |
| config.envFromConfigMaps             | list   | `[]`                                   |             |
| config.envFromSecrets                | list   | `[]`                                   |             |
| container.command                    | list   | `[]`                                   |             |
| container.livenessUrl                | string | `"/"`                                  |             |
| container.port                       | int    | `80`                                   |             |
| container.readyUrl                   | string | `"/"`                                  |             |
| cronJobs                             | list   | `[]`                                   |             |
| deployment.replicas                  | int    | `2`                                    |             |
| deployment.resources.limits.cpu      | string | `"1"`                                  |             |
| deployment.resources.limits.memory   | string | `"512Mi"`                              |             |
| deployment.resources.requests.cpu    | string | `"0.1"`                                |             |
| deployment.resources.requests.memory | string | `"128Mi"`                              |             |
| fullnameOverride                     | string | `""`                                   |             |
| image.pullPolicy                     | string | `"Always"`                             |             |
| image.pullSecrets                    | string | `"dockerhub-scentregrouplimited"`      |             |
| image.repository                     | string | `"nginx"`                              |             |
| image.tag                            | string | `"latest"`                             |             |
| ingress.class                        | string | `"nginx-internal"`                     |             |
| ingress.clusterIssuer                | bool   | `false`                                |             |
| ingress.domain                       | string | `"dev.scg.cloud"`                      |             |
| ingress.enabled                      | bool   | `true`                                 |             |
| ingress.hostnameOverride             | bool   | `false`                                |             |
| ingress.path                         | string | `"/"`                                  |             |
| ingress.sslRedirect                  | string | `"false"`                              |             |
| ingress.tls                          | list   | `[]`                                   |             |
| initContainers                       | list   | `[]`                                   |             |
| jobs                                 | list   | `[]`                                   |             |
| nameOverride                         | string | `""`                                   |             |
| redis.enabled                        | bool   | `false`                                |             |
| sidecars.sso.azureTenant             | string | `"replace_me"`                         |             |
| sidecars.sso.clientId                | string | `"Y2xpZW50SWRfcmVwbGFjZV9tZQo="`       |             |
| sidecars.sso.clientSecret            | string | `"Y2xpZW50U2VjcmV0X3JlcGxhY2VfbWUK"`   |             |
| sidecars.sso.cookieSecret            | string | `"cmVwbGFjZV9tZV9hdF9ydW50aW1lCg=="`   |             |
| sidecars.sso.cookieSecure            | bool   | `false`                                |             |
| sidecars.sso.emailDomains            | string | `"scentregroup.com"`                   |             |
| sidecars.sso.enabled                 | bool   | `false`                                |             |
| sidecars.sso.image                   | string | `"quay.io/pusher/oauth2_proxy:v3.2.0"` |             |
| sidecars.sso.passHostHeader          | bool   | `false`                                |             |
| sidecars.sso.provider                | string | `"azure"`                              |             |
| sidecars.sso.skipProviderButton      | bool   | `true`                                 |             |
| vault.address                        | string | `"https://vault.scentregroup.cloud"`   |             |
| vault.authMountPath                  | string | `""`                                   |             |
| vault.enabled                        | bool   | `false`                                |             |
| vault.role                           | string | `""`                                   |             |
| vault.secretSources                  | string | `""`                                   |             |
| vault.secretTarget                   | string | `""`                                   |             |
| vault.synchronizerImage              | string | `"seanson/vault-k8s-mapper:dev"`       |             |
