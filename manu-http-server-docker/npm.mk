BIN_HTTP_SERVER = $(NPM_BIN_LOCAL_DIRECTORY)/$(PACKAGE_HTTP_SERVER)
BIN_CSS_PREPROCESSOR = $(NPM_BIN_LOCAL_DIRECTORY)/$(PACKAGE_CSS_PREPROCESSOR)

##@ Comandos de NPM
npm-init: install-npm-packages ## Inicializar proyecto
	$(info Proyecto npm inicializado)

check-npm-bin-directory:
ifneq ("$(wildcard $(NPM_BIN_LOCAL_DIRECTORY))", "")
	$(error "No existe la carpeta de npm, intentá ejecutar make install-npm-packages")
endif

# Nota: el doble $ es para que NO lo evalué como una macro de GNU Make
npm-run: check-npm-bin-directory precompile-scss-files ## Ejecutar Servidor HTTP
	$(NPM_BIN_LOCAL_DIRECTORY)/concurrently \
	"$(BIN_HTTP_SERVER) $(HTTP_SERVER_PARAMS)" \
	"$(BIN_CSS_PREPROCESSOR) $(CSS_PREPROCESSOR_WATCH)"

precompile-scss-files:
	$(info Compilando archivos .scss a .css)
	$(BIN_CSS_PREPROCESSOR) $(CSS_PREPROCESSOR_PARAMS)

# Nota: en caso de que el otro target run no funcione
npm-run-alternative: ## Ejecutar Servidor HTTP (Exportando npm como variable de entorno)
	$(info Agregando la ruta node_modules/.bin como variable de entorno en $$PATH de ésta shell..)
	@export PATH="$$PATH:$(NPM_BIN_LOCAL_DIRECTORY_ALTERNATIVE)" && $(BIN_HTTP_SERVER)

# Nota: con --yes en el npm init, nos evita completar los datos de package.json
i install-npm-packages: ## Instalar paquetes npm
	@npm init --yes && npm install $(NPM_PACKAGES) --save-dev

u update-npm-packages: ## Actualizar paquetes npm
	@npm install $(NPM_PACKAGES) --save-dev
