# cambiar "clojure" por el lenguaje que estés practicando
DIR_EXERCISES = clojure
DIR_RELATIVE_ROOT = .

# comandos útiles
MKDIR=mkdir -p
COPY=rsync -vzr

DIRS := $(dir $(wildcard $(DIR_EXERCISES)/*/))

$(DIR_EXERCISES):
	@$(MKDIR) $@

copy-exercises: $(DIR_EXERCISES)
	$(info Copiando ejercicios de la carpeta de Exercism al raíz)
	@$(foreach DIR, $(DIRS), \
		$(COPY) $(DIR) $(subst $(DIR_EXERCISES),,$(DIR_RELATIVE_ROOT)/$(DIR));\
	)

# TODO: admitir nuevos lenguajes
install-clojure:
	$(info Instalando Clojure + Clojure Tools..)
	@git clone git@github.com:practicalli/clojure-deps-edn.git ~/.clojure/
# Clojure CLI tools
	@mkdir -p /tmp && cd /tmp && curl -O https://download.clojure.org/install/linux-install-1.10.3.967.sh && \
	chmod +x linux-install-1.10.3.967.sh && sudo ./linux-install-1.10.3.967.sh
	$(info Instalando paquetes de linux necesarios (rlwrap leinigen)..)
# para el historial de comandos, es interno de clj
	sudo apt install -y rlwrap
# para crear los proyectos
	sudo apt install -y leiningen

.PHONY: copy-exercises install-clojure
