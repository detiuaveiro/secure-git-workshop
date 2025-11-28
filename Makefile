SHELL := /bin/bash
PACKAGES = git python3 jq curl make
DIST=$(shell lsb_release -si)

ifeq ($(shell uname -s),Darwin)
	PKG_SYSTEM := brew
	EXTRA_ARG='' -e
endif

ifeq ($(DIST),$(filter $(DIST),Kali Debian Ubuntu Linuxmint))
	# un(comment) to fit your Linux OS package manager
	PKG_SYSTEM := apt
else 
	PKG_SYSTEM := dnf
endif

fix_gi:
	@if grep -r --color Makefile .gitignore; \
	then \
		sed -i $(EXTRA_ARG) 's/^Makefile/#Makefile/' .gitignore; \
	fi
	@grep -r --color Makefile .gitignore

setup:
	$(foreach var,$(PACKAGES),sudo $(PKG_SYSTEM) install $(var);)

versions:
	@git --version
	@docker --version
	@python3 -V
	@jq --version
	@curl --version
	@make --version

verify:
	@which git
	@which docker && docker ps
	@which python3
	@which jq
	@which curl
	@which make
