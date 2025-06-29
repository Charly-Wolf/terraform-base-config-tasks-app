SHELL := /bin/bash

.PHONY: init
init:
	bash .github/scripts/init.sh

.PHONY: plan
plan:
	bash .github/scripts/plan.sh

.PHONY: aplly
apply:
	bash .github/scripts/apply.sh

.PHONY: destroy
destroy:
	bash .github/scripts/destroy.sh

.PHONY: setup-backend
setup-backend:
	bash .github/scripts/setup-terraform-backend.sh

.PHONY: destroy-backend
destroy-backend:
	bash .github/scripts/destroy-terraform-backend.sh

.PHONY: destroy-all
destroy-all:
	bash .github/scripts/destroy-all.sh