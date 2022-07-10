SHELL = /bin/sh
PROJECT_DIRECTORY :=$(realpath ./)
.SUFFIXES: 
.SUFFIXES: *.yaml, *,.json, *.env

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

export_helm_setup: guard-HELM_NAME guard-HELM_NAMESPACE guard-HELM_RELEASE_NAME guard-HELM_VERSION guard-HELM_REPO
	export HELM_NAME=$(HELM_NAME)
	export HELM_NAMESPACE=$(HELM_NAMESPACE)
	export HELM_RELEASE_NAME=$(HELM_RELEASE_NAME)
	export HELM_VERSION=$(HELM_VERSION)
	export HELM_REPO=$(HELM_REPO)

export_helm_overlay_setup: guard-OVERLAY_APP_NAME guard-OVERLAY_USER_GIVEN_NAME guard-OVERLAY-DEST-NAMESPACE guard-OVERLAY_DEST_SERVER guard-OVERLAY_SRC_PATH guard-OVERLAY_SRC_REPO_URL
	export OVERLAY_APP_NAME=$(OVERLAY_APP_NAME)
	export OVERLAY_USER_GIVEN_NAME=$(OVERLAY_USER_GIVEN_NAME)
	export OVERLAY_DEST_NAMESPACE=$(OVERLAY_DEST_NAMESPACE)
	export OVERLAY_DEST_SERVER=$(OVERLAY_DEST_SERVER)
	export OVERLAY_SRC_PATH=$(OVERLAY_SRC_PATH)
	export OVERLAY_SRC_REPO_URL=$(OVERLAY_SRC_REPO_URL)

generate_helm: export_helm_setup
	mkdir -p $(PROJECT_DIRECTORY)/apps/$(HELM_NAMESPACE)/base
	for base_file in $$(ls $(PROJECT_DIRECTORY)/apps/template/base/); do \
		envsubst < $(PROJECT_DIRECTORY)/apps/template/base/$$base_file > $(PROJECT_DIRECTORY)/apps/$(HELM_NAMESPACE)/base/$$base_file ; \
	done
	
