BIN = node_modules/.bin


# Start the server
s:
	$(BIN)/coffee index.coffee

# Run all of the project-level tests, followed by app-level tests
test: assets
	$(BIN)/mocha $(shell find test -name '*.coffee' -not -path 'test/helpers/*')
	$(BIN)/mocha $(shell find apps/*/test -name '*.coffee' -not -path 'test/helpers/*')

# Generate minified assets from the /assets folder and output it to /public.
assets:
	mkdir -p client/public/assets
	$(BIN)/ezel-assets client/assets/ client/public/assets/

# Deploys to Heroku. Run with `make deploy env=staging` or `make deploy env=production`.
deploy: assets
	$(BIN)/bucketassets -b europa-$(env)
	heroku config:set COMMIT_HASH=$(shell git rev-parse --short HEAD) --app=europa-$(env)
	git push git@heroku.com:europa-$(env).git master

.PHONY: test assets
