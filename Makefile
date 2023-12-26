# Compiler options
CC						:=	gcc
CFLAGS				=	#-Wall -Wextra -Werror -pedanticAUTHOR									=	0x7c00

# Informations
AUTHOR									=	0x7c00
PROJECT_NAME						=	Makefile
GITHUB									=	https://github.com/alex-robert-fr
PROJECT_VERSION					= 1.0.0
COMPILER								= $(shell $(CC) --version | head -n 1 | awk '{print toupper($$1), $$3}')
OS_VERSION							= $(shell lsb_release -si; lsb_release -sr)
BUILD_TYPE							= Debug
MAKEFILE_LAST_UPDATE		:= $(shell date -d "$(shell stat -c %y Makefile)" +'%Y-%m-%d %H:%M')

#	Output
DIST					=	build
OBJDIR				=	#obj

# Includes, sources directories and objects
INCLUDES_DIR	=	src/includes
INCLUDES			= $(foreach dir, $(INCLUDES_DIR), $(wildcard $(dir)/*.h))
SRCS_DIR			=	src src/engine src/entities src/map src/window
SRCS					=	$(foreach dir, $(SRCS_DIR), $(wildcard $(dir)/*.c))
ASSETS_DIR		= src/assets
ASSETS				=	$(foreach dir, $(ASSETS_DIR), $(wildcard $(dir)/*))
OBJS					:=	$(SRCS:.c=.o)

# Libraries
MLX						=	src/lib/minilibx-linux
LIBS					=	$(MLX)

# General UI
CMD_SIZE				:= 100
REAL_SIZE_CMD		=	107
SIZE_THREE_COLS	:=	$(shell expr $(CMD_SIZE) / 3)

# UI Progress Bar
#	SRCS
CURRENT					:= 0
FILENAME				:= ""

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

define banner

$(DARK_PURPLE) ██████╗ ██╗  ██╗███████╗ ██████╗ ██████╗  ██████╗ $(RESET)
$(DARK_PURPLE)██╔═████╗╚██╗██╔╝╚════██║██╔════╝██╔═████╗██╔═████╗$(RESET)
$(PURPLE)██║██╔██║ ╚███╔╝     ██╔╝██║     ██║██╔██║██║██╔██║$(RESET)
$(PURPLE)████╔╝██║ ██╔██╗    ██╔╝ ██║     ████╔╝██║████╔╝██║$(RESET)
$(LIGHT_PURPLE)╚██████╔╝██╔╝ ██╗   ██║  ╚██████╗╚██████╔╝╚██████╔╝$(RESET)
$(LIGHT_PURPLE) ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚═════╝  ╚═════╝ $(RESET)
	
endef
export banner

max_length=$${#srcs[@]}; \
[ $${#includes[@]} -gt $$max_len ] && max_len=$${#includes[@]}; \
[ $${#assets[@]} -gt $$max_len ] && max_len=$${#assets[@]}; \
echo $$max_len)

min_length = $(shell srcs=($(1)); includes=($(2)); \
	if [ $${#srcs[@]} -lt $${#includes[@]} ]; then echo $${#srcs[@]}; \
	else echo $${#includes[@]}; fi)

all: BANNER LIST_FILES

BANNER:
	@clear
	@echo $(SIZE_TWO_COLS)
	@echo -e "$$banner" | while IFS= read -r line; do	\
			printf "%*s%s\n" "$$indent" '' "$$line";	\
		done;
	@printf "$(DARK_PURPLE)╔"
	@printf "%0.s═" `seq 1 51`
	@printf "╦"
	@printf "%0.s═" `seq 1 54`
	@printf "╗\n"
	@printf "║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "• Author: " $(AUTHOR) "Project: " "$(PROJECT_NAME)"
	@printf "║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "• Github: " $(GITHUB) "Version: " "$(PROJECT_VERSION)"
	@printf "║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "• Compiler: " "$(COMPILER)" "OS: " "$(OS_VERSION)"
	@printf "║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-35s$(RESET)$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)$(ITALIC)%-36s$(RESET)$(DARK_PURPLE) ║\n" "• Build Type: " $(BUILD_TYPE) "Last Update: " "$(MAKEFILE_LAST_UPDATE)"
	@printf "╠"
	@printf "%0.s═" `seq 1 51`
	@printf "╩"
	@printf "%0.s═" `seq 1 54`
	@printf "╣$(RESET)\n"

LIST_FILES: FILES_STRUCTURE_SECTION PRE_CHECKS_SECTION

FILES_STRUCTURE_SECTION:
	@printf "$(DARK_PURPLE)║ %-$(REAL_SIZE_CMD)s║\n" " FILE STRUCTURE"
	@printf "╠"
	@printf "%0.s═" `seq 1 $(shell expr $(REAL_SIZE_CMD) - 1)`
	@printf "╣$(RESET)\n"
	@printf "$(DARK_PURPLE)║  $(GREEN)$(BOLD)%-$(SIZE_THREE_COLS)s$(DARK_PURPLE) $(GREEN)$(BOLD)%-$(SIZE_THREE_COLS)s$(DARK_PURPLE) $(GREEN)$(BOLD)%-$(SIZE_THREE_COLS)s$(DARK_PURPLE)║$(RESET)\n" "Sources Files:" "Includes Files:" "Assets Files:"
	@srcs=($(SRCS)); \
	includes=($(INCLUDES)); \
	assets=($(ASSETS)); \
	max=20; \
	i=0; \
	while [ $$i -lt $$max ]; do \
		src=`echo $${srcs[@]:$$i:1}`; \
		include=`echo $${includes[@]:$$i:1}`; \
		asset=`echo $${assets[@]:$$i:1}`; \
		[ -z "$$src" ] && src=" "; \
		[ -z "$$include" ] && include=" "; \
		[ -z "$$asset" ] && asset=" "; \
		printf "$(DARK_PURPLE)║$(WHITE)   %-$(SIZE_THREE_COLS)s  %-$(SIZE_THREE_COLS)s  %-$(SIZE_THREE_COLS)s$(DARK_PURPLE)║\n" "$$src" "$$include" "$$asset"; \
		i=`expr $$i + 1`; \
	done; \
	[ `echo $${srcs[@]} | wc -w` -gt 20 ] && printf "║   %-$(SIZE_THREE_COLS)s║" "+"; \
	[ `echo $${includes[@]} | wc -w` -gt 20 ] && printf "║   %-$(SIZE_THREE_COLS)s  %-$(SIZE_THREE_COLS)s║" "" "+"; \
	[ `echo $${assets[@]} | wc -w` -gt 20 ] && printf "║$(RED)   %-$(SIZE_THREE_COLS)s  %-$(SIZE_THREE_COLS)s  %-$(SIZE_THREE_COLS)s$(DARK_PURPLE)║" "" "" "+"; \
	([ `echo $${srcs[@]} | wc -w` -gt 20 ] || [ `echo $${includes[@]} | wc -w` -gt 20 ] || [ `echo $${assets[@]} | wc -w` -gt 20 ]) && printf "\n";
	@printf "╠"
	@printf "%0.s═" `seq 1 $(shell expr $(REAL_SIZE_CMD) - 1)`
	@printf "╣\n"

PRE_CHECKS_SECTION:
	@printf "$(DARK_PURPLE)║ %-$(REAL_SIZE_CMD)s║\n" "📋 PRE-CHECKS"
	@printf "╠"
	@printf "%0.s═" `seq 1 $(shell expr $(REAL_SIZE_CMD) - 1)`
	@printf "╣$(RESET)\n"

%.o: %.c
	@$(CC) -c $< -o $@ -L$(LIBS) -I$(MLX) $(CFLAGS) 2>/dev/null

clear:
	@rm -rf $(OBJS)

re: clear all





#define update_progress
#	$(eval FILENAME=$(1))
#	$(eval TOTAL_FILES=$(2)) # Nombre total de fichiers
#	$(eval MAX_BAR_LENGTH=$(3))
#
#	$(eval PROGRESS_TEXT="Progression [$(BAR_FILL)$(BAR_EMPTY)] $(PERCENT)%")
#	$(eval PROGRESS_TEXT_LENGTH=$(shell expr `echo -n $(PROGRESS_TEXT) | wc -c` + $(MAX_BAR_LENGTH)))
#
#	$(eval CURRENT=$(shell expr $(CURRENT) + 1))	#	Nombre actuel de fichier traité
#	$(eval PERCENT=$(shell expr $(CURRENT) \* 100 / $(TOTAL_FILES)))	# Pourcentage actuel de fichier traité
#	$(eval FILLED_LENGTH=$(shell expr $(PERCENT) \* $(MAX_BAR_LENGTH) / 100)) # Longueur de la bar de chargement
#	$(eval FILLED_LENGTH_MINUS_ONE=$(shell expr $(FILLED_LENGTH) - 1))
#	$(eval UNFILLED_LENGTH=$(shell expr $(MAX_BAR_LENGTH) - $(FILLED_LENGTH))) # Longueur restante de la bar de chargement
#	$(eval BAR_FILL=$(shell printf "%0.s=" `seq 1 $(FILLED_LENGTH_MINUS_ONE)`)) # Génère la bar de progression
#	$(eval BAR_FILL=$(BAR_FILL)🪐)
#	$(eval BAR_EMPTY=$(if $(shell test $(UNFILLED_LENGTH) -gt 0 && echo true),$(shell printf "%0.s-" `seq 1 $(UNFILLED_LENGTH)`),)) # Génère la longueur restante de la bar de progression
#	printf "%*s%s\r" $(INDENT) '' $(PROGRESS_TEXT)
#	@if [ $(CURRENT) -eq $(TOTAL_FILES) ]; then \
#			echo ""; \
#	fi
#endef
# $(call update_progress, $<, $(words $(SRCS)), 75)


