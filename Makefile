STDERR=2
NULL_DEVICE=/dev/null

GIT_STATUS=$(shell git status --porcelain)
GIT_REMOTE_EXISTS=$(shell git remote | grep -w $(REPOSITORY_NAME) $(STDERR)>$(NULL_DEVICE))

git-log-graph:
	git log --graph --abbrev-commit --decorate --oneline

git-update-subtree: repositorios.cfg
	git pull origin master \
	&& cat $< \
	| grep -v -w -E `git remote | xargs | tr ' ' '|'` \
	| tr --delete ',' \
	| xargs -n2 bash -c '$(MAKE) --no-print-directory git-subtree-add REPOSITORY_NAME=$$0 REPOSITORY_URL=$$1'

git-subtree-add: check-repository-modifications add-remote-repository
	git subtree add --squash --prefix=$(REPOSITORY_NAME) $(REPOSITORY_NAME) master
#	&& git push origin master

check-repository-modifications:
ifneq ("$(GIT_STATUS)", "")
	$(error Existen cambios en el repositorio local, intente confirmarlos para continuar)
endif

add-remote-repository:
ifeq ("$(GIT_REMOTE_EXISTS)","")
	git remote add $(REPOSITORY_NAME) $(REPOSITORY_URL)
endif

check-remote-status:
	git status \
	&& git remote --verbose \
	&& git remote --show origin

# utilizado por el resto de los repositorios mediante Github Actions
git-subtree-pull: check-remote-status
	git subtree pull --prefix=$(REPOSITORY_NAME) $(REPOSITORY_URL) master --squash

upload-changes-to-remote:
	git push origin master

.PHONY: git-log-graph git-update-subtree git-subtree-add check-repository-modifications add-remote-repository git-subtree-pull upload-changes-to-remote
