clean:
	@rm -rf tests/tmp

cleantests:
	@rm -rf tests/tmp/.git
	@rm -rf tests/tmp/empty

gen generate:
	@bash -c 'source tests/helpers.sh && generate ${PWD} tests/tmp'

reset-history: gen
	@./reset-history.sh

test: cleantests
	@./runtests.sh

changelog:
	@git-changelog -Tbio CHANGELOG.md -c angular

release:
	@git add CHANGELOG.md
	@git commit -m "docs: Update changelog for version $(version)"
	@git tag $(version)
	@git push
	@git push --tags

DUTIES = \
	test-changelog \
	test-check \
	test-check-api \
	test-check-dependencies \
	test-check-docs \
	test-check-quality \
	test-check-types \
	test-clean \
	test-coverage \
	test-docs \
	test-docs-deploy \
	test-format \
	test-help \
	test-lock \
	test-release \
	test-setup \
	test-test

$(DUTIES):
	@cd tests/tmp && make $(subst test-,,$@)
