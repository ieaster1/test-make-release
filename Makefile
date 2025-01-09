# Check required tools
REQUIRED_DEPS := gh git
HEAD_BRANCH := $(shell git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)

check_deps:
	$(foreach dep,$(REQUIRED_DEPS),\
		$(if $(shell command -v $(dep) 2> /dev/null),$(info Found $(dep)),$(error Required tool '$(dep)' is missing. Please install it.)))

.PHONY: check_deps

define check_version
	@if [ -z "$(VERSION)" ]; then \
		echo "Error: VERSION is required. Usage: make release VERSION=X.Y.Z"; \
		exit 1; \
	fi
	@if ! echo "$(VERSION)" | grep -qE "^[0-9]+\.[0-9]+\.[0-9]+$$"; then \
		echo "Error: Invalid version format '$(VERSION)'. Must be X.Y.Z"; \
		exit 1; \
	fi
endef

define check_head_branch
	@if [ "$(shell git rev-parse --abbrev-ref HEAD)" != $(HEAD_BRANCH) ]; then \
		echo "Error: You must be on the '$(HEAD_BRANCH)' branch to create a release."; \
		exit 1; \
	fi
endef

.PHONY: release
release: check_deps
	$(call check_version)
	$(call check_head_branch)
	@./build_release.sh $(VERSION)

.PHONY: clean
clean:
	@echo "Cleaning up release files."
	rm -f .release_notes.tmp .github_notes.tmp .changelog_content.tmp .urls.tmp .all_urls.tmp
	@echo "Done."
