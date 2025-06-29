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