# Compiler options
CC						:=	gcc
CFLAGS				=	#-Wall -Wextra -Werror -pedantic

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

# Colors
DARK_PURPLE			= \x1b[38;2;179;153;250m
PURPLE					= \x1b[38;2;196;160;250m
RED							= \x1b[38;2;219;94;115m
LIGHT_PURPLE		= \x1b[38;2;216;177;250m
GREEN						= \x1b[38;2;202;250;166m
YELLOW					= \x1b[38;2;250;235;185m
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
define moon_loading
	$(eval CURRENT_LOADING_INDEX=$(shell expr $(CURRENT_LOADING_INDEX) % $(words $(LOADING_EMOJIS)) + 1))
	@echo -ne "\033[A"
	@printf "\r%$(INDENT).s $(DARK_PURPLE)║ $(word $(CURRENT_LOADING_INDEX), $(LOADING_EMOJIS)) $(BOLD)COMPILING:$(RESET) $(YELLOW)%-$(shell expr $(REAL_SIZE_CMD) - 16)s$(DARK_PURPLE)║$(RESET)\n" "" $(1)
	@sleep 0.1
endef


.PHONY: all BANNER FILES_STRUCTURE_SECTION PRE_CHECKS_SECTION clear re

all: BANNER FILES_STRUCTURE_SECTION PRE_CHECKS_SECTION $(OBJS) WARNINGS_SECTION ERRORS_SECTION SUMMARY_SECTION TESTS_SECTION


BANNER:
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
	$(call close_section)
	$(call display_header_section,🚧,WARNINGS)

ERRORS_SECTION:
	$(call display_header_section,💥,ERRORS)

SUMMARY_SECTION:
	$(call display_header_section,📊,BUILD SUMMARY)

TESTS_SECTION:
	$(call display_header_section,🧪,TESTS)

%.o: %.c
	$(call close_section)
	@echo -ne "\033[A"
	$(call moon_loading,$<)
	@$(CC) -c $< -o $@ -L$(LIBS) -I$(MLX) $(CFLAGS) 2>/dev/null

clear:
	@rm -rf $(OBJS)

re: clear all
