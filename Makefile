# Check required tools
REQUIRED_DEPS := gh git

check_deps:
	$(foreach dep,$(REQUIRED_DEPS),\
		$(if $(shell command -v $(dep) 2> /dev/null),$(info Found $(dep)),$(error Required tool '$(dep)' is missing. Please install it.)))

.PHONY: check_deps

# Environment
ENV ?= development

# Version validation
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

.PHONY: release
release: check_deps
	$(call check_version)
	@echo "Creating release $(VERSION)"
	@# Extract changelog entry for this version
	@awk '/^## \[$(VERSION)\]/{p=1;print;next}/^## \[.*\]/{p=0}p' CHANGELOG.md > .release_notes.md
	@if [ ! -s .release_notes.md ]; then \
		echo "Error: No changelog entry found for version '$(VERSION)' in CHANGELOG.md"; \
		echo "Ensure CHANGELOG.md exists and contains an entry for version: $(VERSION)"; \
		exit 1; \
	fi
	@echo "Found changelog entry for version $(VERSION)"
	@# Create and push tag
	git tag -a "$(VERSION)"
	git push origin "$(VERSION)"
	gh release create "$(VERSION)" \
	  --latest \
	  --title "Release $(VERSION)" \
	  --notes-file .release_notes.md
	@echo "Release $(VERSION) created successfully!"

.PHONY: clean
clean:
	rm -f .release_notes.md
