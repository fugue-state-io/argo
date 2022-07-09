# fugue-state-argo
uses `git-ops`, `argocd-autopilot`
## makefile
### validate_contracts
### generate apps for helm-chart
```make generate_helm HELM_NAME="bitnami/keycloak" HELM_REPO=OVERLAY="github.com/bitnami/charts" HELM_RELEASE_NAME="keycloak" HELM_VERSION="9.4.0"```

### generate layers

### Services to be added
- keycloak
- chart-repo
- image-repo