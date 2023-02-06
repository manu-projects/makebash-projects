RM = rm -rfv

DIR_DEP := .dep
DIR_BIN := bin
DIR_SRC := src
DIR_OBJ := .obj
DIRS := $(DIR_DEP) $(DIR_BIN) $(DIR_SRC) $(DIR_OBJ)
SRC := $(wildcard $(DIR_SRC)/*.c)
DEP := $(SRC:$(DIR_SRC)/%.c=$(DIR_DEP)/%.d)
OBJ := $(SRC:$(DIR_SRC)/%.c=$(DIR_OBJ)/%.o)
BIN := app.out

CC := gcc
CFLAGS := -g #-Wall #-Wextra
INCLUDE :=./include
CPPFLAGS :=-I$(INCLUDE) # le avisamos al pre-procesador de C donde encontrar los archivos de cabecera .h
LDFLAGS := -L/usr/include # gcc le indica al GNU linker la ruta donde buscar bibliotecas
LDLIBS := -lpthread -lcommons # gcc le indica al GNU linker que bibliotecas usar (agregar luego de los source files)

# Ojo..! Estamos usando el operador "=" en vez de ":="
# porque queremos que expansión de la macro sea recursiva (la asignación se dará más adelante, cuando se use en una regla)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DIR_DEP)/$*.tmp.d

.PHONY: all
all: $(DIRS) $(DIR_BIN)/$(BIN)

$(DIRS): ; @mkdir -p $@

$(DIR_BIN)/$(BIN): $(OBJ)
  @echo "Enlazamos los objetos ("$(notdir $^)") para crear el ejecutable ($(notdir $@)) en $(dir $@)"
  @$(CC) $(LDFLAGS) $(CFLAGS) $^ -o $@ $(LDLIBS)

# esta otra solución hace lo mismo que la de abajo toda comentada al parecer, pero esta anda ok
$(OBJ): $(DIR_OBJ)/%.o: $(DIR_SRC)/%.c $(DIR_DEP)/%.d | $(DIR_DEP)
  @echo "Se modificó el archivo ($?)"
  @echo -e "Compilamos el archivo fuente ($(notdir $<)) en objeto en $(dir $@)\n"
  @$(CC) $(DEPFLAGS) $(CPPFLAGS) $(CFLAGS) -c $(DIR_SRC)/$*.c -o $(DIR_OBJ)/$*.o
  @mv -f $(DIR_DEP)/$*.tmp.d $(DIR_DEP)/$*.d && touch $@ # se ejecuta si no hubo error de compilación

# se sugiere que la directiva "include" esté luego de la definición de la macro que se usa como target,
# ó mejor aún al final del Makefile
$(DEP):
include $(wildcard $(DEP))

# --------------------------------------------------------------------

.PHONY: clean
clean:
  @echo "Removiendo ejecutable, objetos y dependencias"
  @-$(RM) $(DIR_BIN)/*.out
  @-$(RM) $(DIR_OBJ)/*.o
  @-$(RM) $(DIR_DEP)/*{.d,.tmp.d}

.PHONY: run
run: ; @-$(DIR_BIN)/$(BIN)

.PHONY: watch
watch:
  @echo "Observando cambios en la aplicación..."
  @while true; do $(MAKE) -q || $(MAKE) --no-print-directory; sleep 1; done
