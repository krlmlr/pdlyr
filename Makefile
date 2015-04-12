all: rd

git:
	test "$$(git status --porcelain | wc -c)" = "0"

master: git
	test $$(git rev-parse --abbrev-ref HEAD) = "master"

gh-pages-init:
	git clone --branch gh-pages . gh-pages

gh-pages-build:
	Rscript -e "devtools::build_vignettes()"
	cp inst/doc/pdlyr.html gh-pages/index.html
	cd gh-pages/ && git fetch && git merge --no-edit origin/master --strategy ours && git add . && git ci --amend --no-edit && git push -f origin gh-pages

gh-pages-push:
	git push origin gh-pages

rd: git
	Rscript -e "library(methods); devtools::document()"
	git add man/ NAMESPACE
	test "$$(git status --porcelain | wc -c)" = "0" || git commit -m "document"

inst/NEWS.Rd: git NEWS.md
	Rscript -e "tools:::news2Rd('$(word 2,$^)', '$@')"
	sed -r -i 's/`([^`]+)`/\\code{\1}/g' $@
	git add $@
	test "$$(git status --porcelain | wc -c)" = "0" || git commit -m "update NEWS.Rd"

tag:
	(echo Release v$$(sed -n -r '/^Version: / {s/.* ([0-9.-]+)$$/\1/;p}' DESCRIPTION); echo; sed -n '/^===/,/^===/{:a;N;/\n===/!ba;p;q}' NEWS.md | head -n -3 | tail -n +3) | git tag -a -F /dev/stdin v$$(sed -n -r '/^Version: / {s/.* ([0-9.-]+)$$/\1/;p}' DESCRIPTION)

bump-cran-desc: master rd
	crant -u 2 -C

bump-gh-desc: master rd
	crant -u 3 -C

bump-desc: master rd
	test "$$(git status --porcelain | wc -c)" = "0"
	sed -i -r '/^Version: / s/( [0-9.]+)$$/\1-0.0/' DESCRIPTION
	git add DESCRIPTION
	test "$$(git status --porcelain | wc -c)" = "0" || git commit -m "add suffix -0.0 to version"
	crant -u 4 -C

bump-cran: bump-cran-desc inst/NEWS.Rd tag

bump-gh: bump-gh-desc inst/NEWS.Rd tag

bump: bump-desc inst/NEWS.Rd tag

bootstrap_snap:
	curl -L https://raw.githubusercontent.com/krlmlr/r-snap-texlive/master/install.sh | sh
	curl -L https://raw.githubusercontent.com/krlmlr/r-snap/master/install.sh | sh

install:
	Rscript -e "sessionInfo()"
	Rscript -e "devtools::install_github('hadley/testthat')"
	Rscript -e "devtools::install_github('krlmlr/plyr')"
	Rscript -e "options(repos = 'http://cran.rstudio.com'); devtools::install_deps(dependencies = TRUE)"

test:
	Rscript -e "devtools::check(document = FALSE, check_dir = '.', cleanup = FALSE)"
	! egrep -A 5 "ERROR|WARNING|NOTE" *.Rcheck/00check.log

covr:
	Rscript -e 'if (!requireNamespace("covr")) devtools::install_github("jimhester/covr"); covr::codecov()'

lintr:
	Rscript -e 'if (!requireNamespace("lintr")) devtools::install_github("jimhester/lintr"); lintr::lint_package()'

wercker-build:
	wercker build --docker-host=unix://var/run/docker.sock
