# HTTP_SERVER=$(NPM_BIN_LOCAL_DIRECTORY)/$(PACKAGE_HTTP_SERVER) $(HTTP_SERVER_PARAMS)

##@ Comandos de NPM
npm-init: install-npm-packages ## Inicializar proyecto
	$(info Proyecto npm inicializado)

check-npm-bin-directory:
ifneq ("$(wildcard $(NPM_BIN_LOCAL_DIRECTORY))", "")
	$(error "No existe la carpeta de npm, intentá ejecutar make install-npm-packages")
endif

# Nota: el doble $ es para que NO lo evalué como una macro de GNU Make
npm-run: check-npm-bin-directory ## Ejecutar Servidor HTTP
	$(NPM_BIN_LOCAL_DIRECTORY)/concurrently \
	"$(NPM_BIN_LOCAL_DIRECTORY)/$(PACKAGE_HTTP_SERVER) $(HTTP_SERVER_PARAMS)" \
	"$(NPM_BIN_LOCAL_DIRECTORY)/node-sass --watch public/assets/styles.scss public/assets/styles.css"

#	$(NPM_BIN_LOCAL_DIRECTORY)/concurrently \
#	"npm:$(PACKAGE_HTTP_SERVER) $(HTTP_SERVER_PARAMS)" \
#	"npm:sass --watch public/assets/styles.scss public/assets/styles.css"

#	$(NPM_BIN_LOCAL_DIRECTORY)/$(PACKAGE_HTTP_SERVER) $(HTTP_SERVER_PARAMS)

# Nota: en caso de que el otro target run no funcione
npm-run-alternative: ## Ejecutar Servidor HTTP (Exportando npm como variable de entorno)
	$(info Agregando la ruta node_modules/.bin como variable de entorno en $$PATH de ésta shell..)
	@export PATH="$$PATH:$(NPM_BIN_LOCAL_DIRECTORY_ALTERNATIVE)" && \
	$(PACKAGE_HTTP_SERVER) $(HTTP_SERVER_PARAMS)

# Nota: con --yes en el npm init, nos evita completar los datos de package.json
i install-npm-packages: ## Instalar paquetes npm
	npm init --yes && npm install $(NPM_PACKAGES) --save-dev

u update-npm-packages: ## Actualizar paquetes npm
	npm install $(NPM_PACKAGES) --save-dev
