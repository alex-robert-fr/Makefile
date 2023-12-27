# Compiler options
CC						:=	gcc
CFLAGS				=	-Wall -Wextra -pedantic

# Project Informations
AUTHOR									=	0x7c00
PROJECT_NAME						=	Makefile
GITHUB									=	https://github.com/alex-robert-fr
PROJECT_VERSION					= 1.0.0
COMPILER								= $(shell $(CC) --version | head -n 1 | awk '{print toupper($$1), $$3}')
OS_VERSION							= $(shell lsb_release -si; lsb_release -sr)
BUILD_TYPE							= Debug
MAKEFILE_LAST_UPDATE		:= $(shell date -d "$(shell stat -c %y Makefile)" +'%Y-%m-%d %H:%M')

#	Directories and Files
DIST					=	build
INCLUDES_DIR	=	src/includes
SRCS_DIR			=	src src/engine src/entities src/map src/window
ASSETS_DIR		= src/assets
INCLUDES			= $(foreach dir, $(INCLUDES_DIR), $(wildcard $(dir)/*.h))
SRCS					=	$(foreach dir, $(SRCS_DIR), $(wildcard $(dir)/*.c))
ASSETS				=	$(foreach dir, $(ASSETS_DIR), $(wildcard $(dir)/*))
OBJS					:=	$(SRCS:.c=.o)
WARNING_LOGS	= warnings.log


# Libraries
MLX						=	src/lib/minilibx-linux
LIBS					=	$(MLX)

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
DARK_PURPLE			= \x1b[38;2;179;153;250m
PURPLE					= \x1b[38;2;196;160;250m
RED							= \x1b[38;2;219;94;115m
LIGHT_PURPLE		= \x1b[38;2;216;177;250m
GREEN						= \x1b[38;2;202;250;166m
YELLOW					= \x1b[38;2;250;235;185m
DARK_YELLOW			= \x1b[38;2;250;235;135m
WHITE						= \x1b[38;2;255;255;255m
RESET						= \x1b[0;0m
BOLD						= \x1b[1m
ITALIC					= \x1b[3m

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

# Function Definition
# Affiche un titre de section
# params: EMOJI, TEXTE
define display_header_section
	@printf "%$(INDENT).s $(DARK_PURPLE)║ %-$(REAL_SIZE_CMD)s║\n" '' "$(1)  $(2)"
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
		$(eval FILLED_LENGTH := $(if $(filter $(CURRENT_INDEX),$(TOTAL_FILES)), $(MAX_BAR_LENGTH), $(shell expr $(CURRENT_INDEX) \* $(MAX_BAR_LENGTH) / $(TOTAL_FILES))))
    $(eval FILLED_PROGRESS_BAR=$(shell printf "%0.s█" $(shell seq 1 $(FILLED_LENGTH))))
		$(eval EMPTY_PROGRESS_BAR=$(shell if [ "$(CURRENT_INDEX)" -eq "$(TOTAL_FILES)" ]; then printf "%0.s" ""; else printf "%0.s░" $(shell seq 1 $(shell expr $(MAX_BAR_LENGTH) - $(FILLED_LENGTH))); fi))
    $(eval TEXT_PROGRESS_BAR=$(shell printf "[%s%s]" "$(FILLED_PROGRESS_BAR)" "$(EMPTY_PROGRESS_BAR)"))
    @printf "\r%$(INDENT).s $(DARK_PURPLE)║"
    @printf "\t  %-$(shell expr $(REAL_SIZE_CMD) - 5)s \t\t\t" $(TEXT_PROGRESS_BAR)
    @printf "║"
endef
# Met en formes les erreur GCC UNIQUEMENT !
define display_warning
	@warning_logs=$(WARNING_LOGS); \
	if [ ! -s "$$warning_logs" ]; then \
		echo "Aucun avertissement de compilation trouvé."; \
	else \
		while IFS= read -r line; do \
			if echo "$$line" | grep -q -E '^[^[:space:]]+/.+:[0-9]+:[0-9]+:'; then \
				file_and_line=$$(echo "$$line" | cut -d ':' -f 1-3); \
				message=$$(echo "$$line" | cut -d ':' -f 5-); \
				printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET) $(LIGHT_PURPLE)$(BOLD)%-104s$(RESET) $(DARK_PURPLE)║$(RESET)\n" "" "$$file_and_line"; \
				is_first_line=true;\
				echo "$$message" | fold -s -w 95 | while IFS= read -r text_line; do \
					trim_text_line=$$(echo "$$text_line" | awk '{$$1=$$1;print}');\
					words_count=$$(echo -n "$$trim_text_line" | wc -m); \
					padding_size=$$(expr $(REAL_SIZE_CMD) - $$words_count); \
					if [ "$$is_first_line" = true ]; then \
						printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET)  $(DARK_YELLOW) $(RESET) %-s%*s$(DARK_PURPLE)║$(RESET)\n" "" "$$trim_text_line" $$(expr $$padding_size - 6) ""; \
						is_first_line=false; \
					else \
						printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET)   %-s%*s$(DARK_PURPLE)║$(RESET)\n" "" "$$trim_text_line" $$(expr $$padding_size - 4) ""; \
					fi; \
				done; \
				printf "%$(INDENT).s $(DARK_PURPLE)║$(RESET)%*s$(DARK_PURPLE)║$(RESET)\n" "" "$$(expr $(REAL_SIZE_CMD) - 1)";\
			fi \
		done < "$$warning_logs"; \
	fi
endef









.PHONY: all BANNER FILES_STRUCTURE_SECTION PRE_CHECKS_SECTION clear re

all: BANNER FILES_STRUCTURE_SECTION PRE_CHECKS_SECTION $(OBJS) WARNINGS_SECTION ERRORS_SECTION SUMMARY_SECTION TESTS_SECTION


BANNER:
	@echo -ne "\x1b[?25l"
	@clear
	@cols=120;	\
	width=51; \
	indent=$$((($$cols - $$width) / 2));	\
	echo -e "$$banner" | while IFS= read -r line; do	\
		printf "%*s%s\n" "$$indent" '' "$$line";	\
	done;
	@printf "%$(INDENT).s $(DARK_PURPLE)╔"
	@printf "%0.s═" `seq 1 51`
	@printf "╦"
	@printf "%0.s═" `seq 1 54`
	@printf "╗\n"
	@printf "%$(INDENT).s ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "" "• Author: " $(AUTHOR) "Project: " "$(PROJECT_NAME)"
	@printf "%$(INDENT).s ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "" "• Github: " $(GITHUB) "Version: " "$(PROJECT_VERSION)"
	@printf "%$(INDENT).s ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "" "• Compiler: " "$(COMPILER)" "OS: " "$(OS_VERSION)"
	@printf "%$(INDENT).s ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "" "• Build Type: " $(BUILD_TYPE) "Last Update: " "$(MAKEFILE_LAST_UPDATE)"
	@printf "%$(INDENT).s ╠"
	@printf "%0.s═" `seq 1 51`
	@printf "╩"
	@printf "%0.s═" `seq 1 54`
	@printf "╣$(RESET)\n"

FILES_STRUCTURE_SECTION:
	$(call display_header_section,,FILE STRUCTURE)
	$(call list_files,$(SRCS),$(INCLUDES))
	$(call close_section)

PRE_CHECKS_SECTION:
	$(call display_header_section,📋,PRE-CHECKS)
	@printf "%$(INDENT).s $(DARK_PURPLE)║     $(GREEN)✔$(WHITE)  %-$(shell expr $(REAL_SIZE_CMD) - 9)s$(DARK_PURPLE)║\n" "" "Headers verified."
	@printf "%$(INDENT).s $(DARK_PURPLE)║     $(GREEN)✔$(WHITE)  %-$(shell expr $(REAL_SIZE_CMD) - 9)s$(DARK_PURPLE)║\n" "" "Source files verified."
	@printf "%$(INDENT).s $(DARK_PURPLE)║     $(GREEN)✔$(WHITE)  %-$(shell expr $(REAL_SIZE_CMD) - 9)s$(DARK_PURPLE)║\n" "" "Libraries up to date."
	$(call close_section)
	$(call close_section)


COMPILING_SECTION:
	$(call display_header_section,🚀,COMPILATION PROCESS)
	$(call close_section)

WARNINGS_SECTION:
	@echo -ne "\n"
	$(call close_section)
	$(call display_header_section,🚧,WARNINGS)
	$(call display_warning)
	$(call close_section)
	@rm -rf $(WARNING_LOGS)

ERRORS_SECTION:
	$(call display_header_section,💥,ERRORS)

SUMMARY_SECTION:
	$(call display_header_section,📊,BUILD SUMMARY)

TESTS_SECTION:
	$(call display_header_section,🧪,TESTS)
	@echo -ne "\x1b[?25h"

%.o: %.c
	@echo -ne "\033[E"
	$(call close_section)
	@echo -ne "\033[2A"
	$(call moon_loading,$<)
	$(call progress_bar,$(words $(SRCS)),75)
	@$(CC) -c $< -o $@ -L$(LIBS) -I$(MLX) $(CFLAGS) 2>> $(WARNING_LOGS)

clear:
	@rm -rf $(OBJS)

re: clear all
