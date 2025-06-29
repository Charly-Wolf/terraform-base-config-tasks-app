SHELL := /bin/bash

.PHONY: init
init:
	bash .github/scripts/init.sh

.PHONY: plan
plan:
	bash .github/scripts/plan.sh

.PHONY: apply
apply:
	bash .github/scripts/apply.sh

.PHONY: setup-backend
setup-backend:
	bash .github/scripts/setup-terraform-backend.sh

.PHONY: destroy
destroy:
	bash .github/scripts/destroy.sh $(what-to-destroy)
	