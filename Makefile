# Compiler options
CC						:=	gcc
CFLAGS				=	#-Wall -Wextra -Werror -pedanticAUTHOR									=	0x7c00

# Informations
AUTHOR									=	0x7c00
PROJECT_NAME						=	project_name
GITHUB									=	https://github.com/alex-robert-fr
PROJECT_VERSION					= 1.0.0
COMPILER								= $(shell $(CC) --version | head -n 1 | awk '{print toupper($$1), $$3}')
OS_VERSION							= $(shell lsb_release -si; lsb_release -sr)
BUILD_TYPE							= Debug
MAKEFILE_LAST_UPDATE		= 2023

#	Output
DIST					=	build
OBJDIR				=	#obj

# Includes, sources directories and objects
INCLUDES_DIR	=	inc
SRCS_DIR			:=	src src/engine src/entities src/map src/window
SRCS					:=	$(foreach dir, $(SRCS_DIR), $(wildcard $(dir)/*.c))
OBJS					:=	$(SRCS:.c=.o)

# Libraries
MLX						=	src/lib/minilibx-linux
LIBS					=	$(MLX)

# General UI
CMD_SIZE				:= 109

# UI Progress Bar
#	SRCS
CURRENT					:= 0
FILENAME				:= ""

# Colors
DARK_PURPLE			= \x1b[38;2;179;153;250m
PURPLE					= \x1b[38;2;196;160;250m
LIGHT_PURPLE		= \x1b[38;2;216;177;250m
GREEN						= \x1b[38;2;202;250;166m
YELLOW					= \x1b[38;2;250;235;185m
RESET						= \x1b[0;0m

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

all: BANNER

BANNER:
	@clear
	@echo -e "$$banner" | while IFS= read -r line; do	\
			printf "%*s%s\n" "$$indent" '' "$$line";	\
		done;
	@printf "$(DARK_PURPLE)╔"
	@printf "%0.s═" `seq 1 51`
	@printf "╦"
	@printf "%0.s═" `seq 1 53`
	@printf "╗\n"
	@printf "║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║\n" "• Author: " $(AUTHOR) "Project: " "$(PROJECT_NAME)"
	@printf "║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║\n" "• Github: " $(GITHUB) "Version: " "$(PROJECT_VERSION)"
	@printf "║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║\n" "• Compiler: " "$(COMPILER)" "OS: " "$(OS_VERSION)"
	@printf "║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║ $(GREEN)%-16s$(YELLOW)%-35s$(DARK_PURPLE) ║\n" "• Build Type: " $(BUILD_TYPE) "Last Update: " "$(MAKEFILE_LAST_UPDATE)"
	@printf "╚"
	@printf "%0.s═" `seq 1 51`
	@printf "╩"
	@printf "%0.s═" `seq 1 53`
	@printf "╝$(RESET)\n"

CHECK_FILES:
		@printf "📋 CHECKING FILES:\n"

CHECK_HEADERS:
		@printf "\t%*s[%s] Checking headers files in the %s folder\n" "$$indent" '' $(CHECK) $(INCLUDES_DIR)

CHECK_SRCS:
		@printf "\t%*s[%s] Checking sources files in the %s folder\n" "$$indent" '' $(CHECK) $(SRCS_DIR)

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


