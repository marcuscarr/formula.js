webpack = node_modules/.bin/webpack
jshint = node_modules/.bin/jshint
mocha = node_modules/.bin/mocha
browserify = node_modules/.bin/browserify
http-server = node_modules/.bin/http-server
codeclimate-test-reporter = node_modules/.bin/codeclimate-test-reporter

build:
	@$(webpack)
	@$(webpack) --config .config/production.js

test:
	@$(mocha) -u bdd --exit

test-browser:
	@mkdir -p tmp
	@$(browserify) test/index.js -s formulajs > tmp/test.js
	@$(http-server) -p 8088 -s -o

test-watch:
	@$(mocha) -u bdd -R min -w

lint:
	@$(jshint) lib/*.js

coverage:
	@mkdir -p coverage
	@$(mocha) -r blanket -u bdd -R mocha-lcov-reporter > coverage/lcov.info
	@$(mocha) -u bdd -R html-cov -r blanket > coverage/coverage-report.html

package: clean build
	rm -rf *.tgz || true
	@npm pack

watch:
	@$(mocha) -u bdd -R mocha-spec-cov -r blanket -w

clean:
	@rm -rf build/
	@rm -f coverage-report.html

.PHONY: build clean coverage test watch
