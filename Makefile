#_PROJECT_NAME			=	progect_name
#_PROJECT_VERSION		=	1.0.0
#_INCLUDES_DIR			=	src/includes
#_SRCS_DIR					=	src src/folder1 src/folder2
#_LIBS_DIR					=	-Lsrc/lib
#_INCLUDES_FLAGS		=	-Isrc/includes
#_LIBS_FLAGS				=	-lglfw -lm
#_CFLAGS						= -pendantic





# NE PAS TOUCHER !!!

include make-tools/project-config.mk	# Configuration de projet
# Compiler options
CC						:=	gcc
CFLAGS				= $(_INCLUDES_FLAGS) $(_LIBS_FLAGS) -Wall -Wextra $(_CFLAGS)

# Project Informations
AUTHOR									=	0x7c00
PROJECT_NAME						=	$(_PROJECT_NAME)
GITHUB									=	https://github.com/alex-robert-fr
PROJECT_VERSION					= $(_PROJECT_VERSION)
COMPILER								= $(shell $(CC) --version | head -n 1 | awk '{print toupper($$1), $$3}')
OS_VERSION							= $(shell lsb_release -si; lsb_release -sr)
BUILD_TYPE							= Debug
MAKEFILE_LAST_UPDATE		:= $(shell date -d "$(shell stat -c %y Makefile)" +'%Y-%m-%d %H:%M')

#	Directories and Files
DIST					=	build
INCLUDES_DIR	=	$(_INCLUDES_DIR)
SRCS_DIR			=	$(_SRCS_DIR)
INCLUDES			= $(foreach dir, $(INCLUDES_DIR), $(wildcard $(dir)/*.h))
SRCS					=	$(foreach dir, $(SRCS_DIR), $(wildcard $(dir)/*.c))
OBJS					:=	$(SRCS:.c=.o)
WARNING_LOGS	= warnings.tmp.log
ERROR_LOGS		= error.tmp.log
ERROR_COUNT		= error_count.tmp
TIME_TMP			=	time.tmp


# Libraries
LIBS					=	$(_LIBS_DIR)

# UI Configuration
CMD_SIZE				:= 100
REAL_SIZE_CMD		=	107
SIZE_TWO_COLS		:=	$(shell expr $(CMD_SIZE) / 2)
INDENT					= 4

# Loading
LOADING_EMOJIS := 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘
CURRENT_LOADING_INDEX := 0
CURRENT_INDEX					:= 0

# Colors
include ./make-tools/ui/font-custom.mk
# UI Emoji
CHECK						=	✔

# Banner
define banner

$(DARK_PURPLE) ██████╗ ██╗  ██╗███████╗ ██████╗ ██████╗  ██████╗ $(RESET)
$(DARK_PURPLE)██╔═████╗╚██╗██╔╝╚════██║██╔════╝██╔═████╗██╔═████╗$(RESET)
$(PURPLE)██║██╔██║ ╚███╔╝     ██╔╝██║     ██║██╔██║██║██╔██║$(RESET)
$(PURPLE)████╔╝██║ ██╔██╗    ██╔╝ ██║     ████╔╝██║████╔╝██║$(RESET)
$(LIGHT_PURPLE)╚██████╔╝██╔╝ ██╗   ██║  ╚██████╗╚██████╔╝╚██████╔╝$(RESET)
$(LIGHT_PURPLE) ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚═════╝  ╚═════╝ $(RESET)
	
endef
export banner

include make-tools/cursor.mk

# Function Definition
# Affiche un titre de section
# params: EMOJI, TEXTE, Margin
define display_header_section
	@printf "%$(INDENT).s $(DARK_PURPLE)║ $(WHITE)$(BOLD)%-$(shell expr $(REAL_SIZE_CMD) + $(3))s$(RESET)$(DARK_PURPLE)║\n" '' "$(1)  $(2)"
	@printf "%$(INDENT).s ╠"
	@printf "%0.s═" `seq 1 $(shell expr $(REAL_SIZE_CMD) - 1)`
	@printf "╣$(RESET)\n"
endef
# Affiche la fin de section
define close_section
	@printf "%$(INDENT).s$(DARK_PURPLE) ╠"
	@printf "%0.s═" `seq 1 $(shell expr $(REAL_SIZE_CMD) - 1)`
	@printf "╣$(RESET)\n"
endef
define close_page
	@printf "%$(INDENT).s$(DARK_PURPLE) ╚"
	@printf "%0.s═" `seq 1 $(shell expr $(REAL_SIZE_CMD) - 1)`
	@printf "╝$(RESET)\n"
endef
# Retourne le nombre le plus grand
# params: Array1, Array2
define max_count
	$(if $(shell test $(words $(1)) -ge $(words $(2)); echo $$?),$(words $(1)), $(words $(2)))
endef
# Liste les fichiers sources et headers sur deux colonnes
# params: Array_Srcs, Array_Includes
define list_files
	@printf "%$(INDENT).s $(DARK_PURPLE)║  $(GREEN)$(BOLD)%-$(SIZE_TWO_COLS)s$(DARK_PURPLE) $(GREEN)$(BOLD)%-$(SIZE_TWO_COLS)s$(DARK_PURPLE) ║$(RESET)\n" "" "Sources Files:" "Includes Files:"
	$(eval max := $(call max_count,$(1),$(2))) 
	@i=1; \
	while [ $$i -le $(max) ]; do \
		src_file=""; \
		include_file=""; \
		if [ $$i -le $(words $(1)) ]; then \
			src_file=`echo $(1) | cut -d' ' -f$$i`; \
		fi; \
		if [ $$i -le $(words $(2)) ]; then \
			include_file=`echo $(2) | cut -d' ' -f$$i`; \
		fi; \
		printf "%$(INDENT).s $(DARK_PURPLE)║$(WHITE)   %-$(SIZE_TWO_COLS)s  %-$(SIZE_TWO_COLS)s$(DARK_PURPLE) ║\n" "" "$$src_file" "$$include_file"; \
		i=$$((i + 1)); \
	done
endef
# Animation de chargement
# params Nom_de_fichier_actuel
define moon_loading
	$(eval CURRENT_LOADING_INDEX=$(shell expr $(CURRENT_LOADING_INDEX) % $(words $(LOADING_EMOJIS)) + 1))
	@echo -ne "\033[A"
	@printf "\r%$(INDENT).s $(DARK_PURPLE)║ $(word $(CURRENT_LOADING_INDEX), $(LOADING_EMOJIS)) $(BOLD)COMPILING:$(RESET) $(YELLOW)%-$(shell expr $(REAL_SIZE_CMD) - 16)s$(DARK_PURPLE)║$(RESET)\n" "" $(1)
endef
# Barre de progression
# params nombre_total_fichiers, width, current_index
define progress_bar
    $(eval TOTAL_FILES=$(1))
    $(eval MAX_BAR_LENGTH=$(2))
    $(eval CURRENT_INDEX=$(shell expr $(CURRENT_INDEX) + 1))
		$(eval PERCENT=$(shell expr $(CURRENT_INDEX) \* 100 / $(TOTAL_FILES)))
		$(eval FILLED_LENGTH := $(if $(filter $(CURRENT_INDEX),$(TOTAL_FILES)), $(MAX_BAR_LENGTH), $(shell expr $(CURRENT_INDEX) \* $(MAX_BAR_LENGTH) / $(TOTAL_FILES))))
    $(eval FILLED_PROGRESS_BAR=$(shell printf "%0.s█" $(shell seq 1 $(FILLED_LENGTH))))
		$(eval EMPTY_PROGRESS_BAR=$(shell if [ "$(CURRENT_INDEX)" -eq "$(TOTAL_FILES)" ]; then printf "%0.s" ""; else printf "%0.s░" $(shell seq 1 $(shell expr $(MAX_BAR_LENGTH) - $(FILLED_LENGTH))); fi))
    $(eval TEXT_PROGRESS_BAR=$(shell printf "[%s%s]" "$(FILLED_PROGRESS_BAR)" "$(EMPTY_PROGRESS_BAR)"))
    @printf "\r%$(INDENT).s $(DARK_PURPLE)║"
    @printf "\t  %-$(shell expr $(REAL_SIZE_CMD))s %s%% \t\t\t" $(TEXT_PROGRESS_BAR) $(PERCENT)
    @printf "║"
endef
# Met en formes les erreur GCC UNIQUEMENT !
# params fichier_logs, type_a_rechercher, couleur_icone, count
define display_warning
	@warning_logs=$(1); \
	if [ $(4) -eq 0 ]; then \
		printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET) Aucun avertissement de compilation trouvé.%*s$(DARK_PURPLE)║$(RESET)\n" "" "63"; \
	else \
		while IFS= read -r line; do \
				file_and_line=$$(echo "$$line" | cut -d ':' -f 1-3); \
				message=$$(echo "$$line" | cut -d ':' -f 5-); \
				printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET) $(LIGHT_PURPLE)$(BOLD)%-104s$(RESET) $(DARK_PURPLE)║$(RESET)\n" "" "$$file_and_line"; \
				is_first_line=true;\
				echo "$$message" | fold -s -w 100 | while IFS= read -r text_line; do \
					trim_text_line=$$(echo "$$text_line" | awk '{$$1=$$1;print}');\
					words_count=$$(echo -n "$$trim_text_line" | wc -m); \
					padding_size=$$(expr $(REAL_SIZE_CMD) - $$words_count); \
					if [ "$$is_first_line" = true ]; then \
						printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET)  $(3) $(RESET) %-s%*s$(DARK_PURPLE)║$(RESET)\n" "" "$$trim_text_line" $$(expr $$padding_size - 6) ""; \
						is_first_line=false; \
					else \
						printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET)     %-s%*s$(DARK_PURPLE)║$(RESET)\n" "" "$$trim_text_line" $$(expr $$padding_size - 6) ""; \
					fi; \
				done; \
				printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET)%*s$(DARK_PURPLE)║$(RESET)\n" "" "$$(expr $(REAL_SIZE_CMD) - 1)";\
		done < "$$warning_logs"; \
	fi
endef







all: record_start_time CREATE_TMP BANNER FILES_STRUCTURE_SECTION PRE_CHECKS_SECTION $(OBJS) WARNINGS_SECTION ERRORS_SECTION record_end_time SUMMARY_SECTION REMOVE_TMP 

record_start_time:
	@echo $$(date '+%s%N') > start_time.log

record_end_time:
	@end_time=$$(date '+%s%N'); \
	start_time=$$(cat start_time.log); \
	duration_ns=$$((end_time - start_time)); \
	duration_sec=$$((duration_ns / 1000000000)); \
	duration_ms=$$((duration_ns % 1000000000)); \
	total=$$(echo "scale=2; ($$duration_ms / 1000000000)" | bc); \
	echo "$$duration_sec$$total" > $(TIME_TMP)


CREATE_TMP:
	@echo 0 > $(ERROR_COUNT)

REMOVE_TMP:
	@rm -rf $(WARNING_LOGS)
	@rm -rf $(ERROR_COUNT)
	@rm -rf $(ERROR_LOGS)
	@rm -rf $(TIME_TMP)
	@rm -rf temp start_time.log build_time.log

FILTER_LOGS:
	@grep "attention:" $(ERROR_LOGS) > $(WARNING_LOGS) || true
	@grep "erreur:" $(ERROR_LOGS) > temp && mv temp $(ERROR_LOGS) || true

include make-tools/banner.mk

FILES_STRUCTURE_SECTION:
	$(call display_header_section,,FILE STRUCTURE,0)
	$(call list_files,$(SRCS),$(INCLUDES))
	$(call close_section)

PRE_CHECKS_SECTION:
	$(call display_header_section,📋,PRE-CHECKS,0)
	@printf "%$(INDENT).s $(DARK_PURPLE)║     $(GREEN)✔$(WHITE)  %-$(shell expr $(REAL_SIZE_CMD) - 9)s$(DARK_PURPLE)║\n" "" "Headers verified."
	@printf "%$(INDENT).s $(DARK_PURPLE)║     $(GREEN)✔$(WHITE)  %-$(shell expr $(REAL_SIZE_CMD) - 9)s$(DARK_PURPLE)║\n" "" "Source files verified."
	@printf "%$(INDENT).s $(DARK_PURPLE)║     $(GREEN)✔$(WHITE)  %-$(shell expr $(REAL_SIZE_CMD) - 9)s$(DARK_PURPLE)║\n" "" "Libraries up to date."
	$(call close_section)
	$(call close_section)


COMPILING_SECTION:
	$(call display_header_section,🚀,COMPILATION PROCESS,0)
	$(call close_section)

WARNINGS_SECTION: FILTER_LOGS
	@echo -ne "\n"
	$(call close_section)
	$(call display_header_section,🚧,$$(wc -l < $(WARNING_LOGS)) WARNINGS trouvées,1)
	$(call display_warning,$(WARNING_LOGS),attention,$(DARK_YELLOW),$$(($$(wc -l < $(WARNING_LOGS)))))
	$(call close_section)

ERRORS_SECTION: 
	$(call display_header_section,💥,`cat $(ERROR_COUNT)` ERREURS trouvées,1)
	$(call display_warning,$(ERROR_LOGS),erreur,$(DARK_RED),`cat $(ERROR_COUNT)`)
	$(call close_section)

SUMMARY_SECTION:
	$(call display_header_section,📊,BUILD SUMMARY,0)
	@printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET)     $(GREEN)Files Compiled: $(WHITE)$(BOLD)%s\t$(DARK_YELLOW)Warnings: $(WHITE)$(BOLD)%s\t$(DARK_RED)Errors: $(WHITE)$(BOLD)%s\t$(LIGHT_PURPLE)Time: $(WHITE)$(BOLD)%ss%-$(shell expr $(REAL_SIZE_CMD) - 71)s$(DARK_PURPLE) ║\n" "" $$(expr $(TOTAL_FILES) - `cat $(ERROR_COUNT)`) $$(wc -l < $(WARNING_LOGS)) $$(wc -l < $(ERROR_LOGS) | awk '{print $$1}') $$(cat $(TIME_TMP))
	$(call close_page)
	@echo -ne "\x1b[?25h"

TESTS_SECTION:
	$(call display_header_section,🧪,TESTS,0)

%.o: %.c
	@echo -ne "\033[E"
	$(call close_section)
	@echo -ne "\033[2A"
	$(call moon_loading,$<)
	$(call progress_bar,$(words $(SRCS)),75)
	@if ! $(CC) -c $< -o $@ $(LIBS) $(CFLAGS) 2>> $(ERROR_LOGS); then \
		expr `cat $(ERROR_COUNT)` + 1 > $(ERROR_COUNT);\
	fi

update:
	@./make-tools/update.sh

clear:
	@rm -rf $(OBJS)

re: clear all


