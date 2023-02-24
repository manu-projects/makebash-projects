BAT=bat --line-range $(NUMBER_LINE_BEGIN_DOCUMENTATION):

NAWK_HEADERS=nawk 'BEGIN{print "Comando | Descripción"} {print $$0}' | column -t -s "|"

TRUNCATE_CLEAR_CONTENT=truncate -s 0
