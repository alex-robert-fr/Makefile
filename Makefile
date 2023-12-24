AUTHOR				=	0x7c00
GITHUB				=	https://github.com/alex-robert-fr
PROJECT_NAME	=	project_name

#	Output
DIST					=	build
OBJDIR				=	#obj

# Includes, sources directories and objects
INCLUDES_DIR	=	#inc
SRCS_DIR			:=	src src/engine src/entities src/map src/window
SRCS					:=	$(foreach dir, $(SRCS_DIR), $(wildcard $(dir)/*.c))
OBJS					:=	$(SRCS:.c=.o)

# Libraries
MLX						=	src/lib/minilibx-linux
LIBS					=	$(MLX)


# Compiler options
CC						=	gcc
CFLAGS				=	#-Wall -Wextra -Werror -pedantic

# UI Progress Bar
TOTAL_FILES			:= $(words $(SRCS))
MAX_BAR_LENGTH	:= 75
PROGRESS_TEXT		= "Progression [$(BAR_FILL)$(BAR_EMPTY)] $(PERCENT)%"
PROGRESS_TEXT_LENGTH := $(shell expr `echo -n $(PROGRESS_TEXT) | wc -c` + $(MAX_BAR_LENGTH))
INDENT					:= $(shell expr \( `tput cols` - $(PROGRESS_TEXT_LENGTH) \) / 2)
FILENAME				:= ""

# Colors
WHITE						= \x1b[38;2;111;97;192m
PINK						= \x1b[38;2;160;132;232m
PURPLE					= \x1b[38;2;139;232;229m
DARK_PURPLE			= \x1b[38;2;213;255;228m
RESET						= \x1b[0;0m

define banner

 ██████╗ ██╗  ██╗███████╗ ██████╗ ██████╗  ██████╗ 
██╔═████╗╚██╗██╔╝╚════██║██╔════╝██╔═████╗██╔═████╗
██║██╔██║ ╚███╔╝     ██╔╝██║     ██║██╔██║██║██╔██║
████╔╝██║ ██╔██╗    ██╔╝ ██║     ████╔╝██║████╔╝██║
╚██████╔╝██╔╝ ██╗   ██║  ╚██████╗╚██████╔╝╚██████╔╝
 ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚═════╝  ╚═════╝                                      
						
	• Author: $(AUTHOR)
	• Github: $(GITHUB)
	• Project: $(PROJECT_NAME)


endef
export banner

define update_progress
	$(eval CURRENT=$(shell expr $(CURRENT) + 1))	#	Nombre actuel de fichier traité
	$(eval PERCENT=$(shell expr $(CURRENT) \* 100 / $(TOTAL_FILES)))	# Pourcentage actuel de fichier traité
	$(eval FILLED_LENGTH=$(shell expr $(PERCENT) \* $(MAX_BAR_LENGTH) / 100)) # Longueur de la bar de chargement
	$(eval FILLED_LENGTH_MINUS_ONE=$(shell expr $(FILLED_LENGTH) - 1))
	$(eval UNFILLED_LENGTH=$(shell expr $(MAX_BAR_LENGTH) - $(FILLED_LENGTH))) # Longueur restante de la bar de chargement
	$(eval BAR_FILL=$(shell printf "%0.s=" `seq 1 $(FILLED_LENGTH_MINUS_ONE)`)) # Génère la bar de progression
	$(eval BAR_FILL=$(BAR_FILL)🪐)
	$(eval BAR_EMPTY=$(if $(shell test $(UNFILLED_LENGTH) -gt 0 && echo true),$(shell printf "%0.s-" `seq 1 $(UNFILLED_LENGTH)`),)) # Génère la longueur restante de la bar de progression
	$(eval FILENAME=$(1))
	printf "\033[A\r\033[K"
	printf "%*s%s\n" $(INDENT) '' $(FILENAME)
	printf "%*s%s\r" $(INDENT) '' $(PROGRESS_TEXT)
	@if [ $(CURRENT) -eq $(TOTAL_FILES) ]; then \
			echo ""; \
	fi
endef

all: BANNER $(OBJS)

BANNER:
	@clear
	@printf "$(WHITE)8888$(RESET)"
	@printf "$(PINK)8888$(RESET)"
	@printf "$(PURPLE)8888$(RESET)"
	@printf "$(DARK_PURPLE)8888$(RESET)"
	@cols=$$(tput cols);	\
		banner_width=51;		\
		indent=$$((($$cols - $$banner_width) / 2));		\
		echo "$$banner" | while IFS= read -r line; do	\
			printf "%*s%s\n" "$$indent" '' "$$line";	\
		done;

%.o: %.c
	@$(CC) -c $< -o $@ -L$(LIBS) -I$(MLX) $(CFLAGS) 2>/dev/null
	@$(call update_progress, $<)

clear:
	@rm -rf $(OBJS)

re: clear all
