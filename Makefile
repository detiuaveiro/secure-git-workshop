SHELL := /bin/bash

BRANCH ?= step2

talisman_setup:
	@echo configure
	if ! test -d bin; then mkdir -p bin/; fi
	curl https://raw.githubusercontent.com/thoughtworks/talisman/main/install.sh > bin/install-talisman.sh
	chmod +x bin/install-talisman.sh

	@echo cleanup
	if test -f .git/hooks/pre-commit; then rm -i .git/hooks/pre-commit; fi
	if test -f .git/hooks/commit-msg; then rm -i .git/hooks/commit-msg; fi
	if test -f .git/hooks/prepare-commit-msg; then rm -i .git/hooks/prepare-commit-msg; fi

	@echo install
	./bin/install-talisman.sh pre-commit
    echo "talisman -g pre-commit" >> .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit

secret_detection: audit_trufflehog

audit_trufflehog:
	@echo "Running trufflehog"
	docker run \
		-t \
		-it \
		--rm \
		-v $(PWD):/target \
		trufflesecurity/trufflehog:latest filesystem /target \
		--json \
		| jq -C
