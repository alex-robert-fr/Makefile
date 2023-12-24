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
TOTAL_FILES		:= $(words $(SRCS))
CURRENT				:= 0

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
	$(eval CURRENT=$(shell echo $(CURRENT) + 1 | bc))
	@printf "Progression : [$(CURRENT)/$(TOTAL_FILES)] %d%%\r" $$(expr $(CURRENT) \* 100 / $(TOTAL_FILES))
	@if [ $(CURRENT) -eq $(TOTAL_FILES) ]; then \
		echo ""; \
	fi
endef

all: BANNER $(OBJS)

BANNER:
	@clear
	@cols=$$(tput cols);	\
		banner_width=51;		\
		indent=$$((($$cols - $$banner_width) / 2));		\
		echo "$$banner" | while IFS= read -r line; do	\
			printf "%*s%s\n" "$$indent" '' "$$line";	\
		done;

%.o: %.c
	@$(CC) -c $< -o $@ -L$(LIBS) -I$(MLX) $(CFLAGS) 2>/dev/null
	@$(call update_progress)

clear:
	@rm -rf $(OBJS)

re: clear all
