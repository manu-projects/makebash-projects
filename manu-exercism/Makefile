-include Makefile.cfg

# comandos útiles
MKDIR=mkdir -p

COPY_OPTIONS= --exclude='project.clj' --exclude='HELP.md' \
	--include='*.md' --include='*.clj' \
	--include='*/' --exclude='*' \
	--prune-empty-dirs

COPY=rsync -vzr #$(COPY_OPTIONS)

DIRECTORIES_EXERCISES_FROM=$(dir $(wildcard $(DIR_EXERCISM_EXERCISES_FROM)/*/))

$(DIR_EXERCISES_TO):
	@$(MKDIR) $@

configure-exercism-workspace:
	$(info Configurando el workspace de Exercism para Clojure..)
	@exercism configure --workspace $(DIR_RELATIVE_ROOT)

# al dejar la ruta como dependencia buscará el target que lo cree si no existiera el directorio,
# por tanto usará el target que definimos previamente que crea la carpeta
copy-exercism-exercises: check-directories-exercism $(DIR_EXERCISES_TO)
	$(info Copiando ejercicios de la carpeta de Exercism al raíz)
	$(foreach DIR_EXERCISE_FROM, $(DIRECTORIES_EXERCISES_FROM), \
		$(COPY) $(DIR_EXERCISE_FROM) $(subst $(DIR_EXERCISM_EXERCISES_FROM),$(DIR_EXERCISES_TO),$(DIR_EXERCISE_FROM));\
	)

check-directories-exercism:
ifeq ("$(wildcard $(DIRECTORIES_EXERCISES_FROM))", "")
	$(error No existen directorios de ejercicios de Exercism en $(DIRECTORIES_EXERCISES_FROM))
endif

download-clojure:
	$(info Descargando Clojure..)
	@git clone git@github.com:practicalli/clojure-deps-edn.git ~/.clojure/
	@$(MKDIR) /tmp && cd /tmp && curl -O $(CLOJURE_INSTALLATION_URL) && \
	chmod u+x $(CLOJURE_INSTALLATION_NAME)

# TODO: admitir nuevos lenguajes
# rlwrap, para el historial de comandos, es interno de clj
# leinigen, para crear los proyectos
install-clojure: download-clojure
	$(info Instalando Clojure + Clojure Tools..)
	 sudo /tmp/$(CLOJURE_INSTALLATION_NAME)

	$(info Instalando paquetes de linux necesarios..)
	sudo apt install -y rlwrap leinigen


.PHONY: copy-exercises install-clojure download-clojure configure-exercism-workspace check-directories-exercism
