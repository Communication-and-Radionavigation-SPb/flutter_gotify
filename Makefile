DOCS_SRC=./doc/api
FTRS=./lib/flutter_gotify
SCRIPTS=./scripts/_define_feature.bash 
# define feature bash script
DFTR=./scripts/_define_feature.bash


args = $(foreach a,$($(subst -,_,$1)_args),$(if $(value $a),$($a)))

release_args = env target

# If the first argument is "feature"...
ifeq (feature,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif


.PHONY: permissions-def
permissions-def:
	@chmod +x $(SCRIPTS)

# Creates new application features folder structure
.PHONY: feature
feature: permissions-def
	@$(DFTR) $(FTRS) $(RUN_ARGS)
# Sets up build_runner to watch for project changes
.PHONY: watch
watch:
	dart run build_runner watch
# Sets up build_runner to watch for project changes and removes conflicting outputs
.PHONY: watch-clean
watch-clean:
	flutter pub run build_runner watch --delete-conflicting-outputs

# Sets up build_runner to build project
.PHONY: build
build:
	flutter pub run build_runner build
# Sets up build_runner to build project and removes conflicting outputs
.PHONY: build-clean
build-clean:
	flutter pub run build_runner build --delete-conflicting-outputs
	
# Runs tests for the scratch project
.PHONY: test
test:
	flutter test
# Generates coverage file of the project
.PHONY: coverage-run
coverage-run:
	flutter test --coverage
.PHONY: coverage-clear
coverage-clear:
	dart run remove_from_coverage -f coverage/lcov.info -r '(?:(?:\.g)|(?:\.freezed))\.dart$$'

.PHONY: coverage
coverage: coverage-run coverage-clear

# Creates AppLocalizations class
.PHONY: locale
locale:
	flutter gen-l10n
# Removes all build artifacts
.PHONY: cleanup
cleanup:
	flutter clean

# Installs project dependencies
.PHONY: install
install:
	flutter pub get


BUILD_ENVIRONMENT = $(word 1, $(call args,$@))
# Builds up APK
.PHONY: release
release:
	$(info Possible environment values are: env=PROD|STAGING|DEV)
	flutter build apk --release --dart-define=ENVIRONMENT=$(BUILD_ENVIRONMENT) 

# Clean up project and build generated
.PHONY: git-clean
git-clean: cleanup install build-clean

# Builds up APK from scratch
.PHONY: flat-release
flat-release: cleanup release

# Build docs
.PHONY: docs-build
docs-build:
	flutter pub run dartdoc --output $(DOCS_SRC) --show-progress

# Run docs on localhost
.PHONY: docs
docs: 
	@echo Go to server: http://localhost:8080
	flutter pub run dhttpd --path $(DOCS_SRC)

# Run widgetbook application on linux platform
.PHONY: wbook
wbook:
	@echo Running Widget book
	flutter run -t lib/widgetbook.dart -d linux


# Run generate documentation
.PHONY: doc
doc:
	dart doc