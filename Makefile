AUTHOR				=	0x7c00
GITHUB				=	https://github.com/alex-robert-fr
PROJECT_NAME	=	project_name

#	Output
DIST					=	build
OBJDIR				=	#obj

# Includes and src directory
INCLUDES_DIR	=	#inc
SRCS_DIR			=	#src

# Compiler options
CFLAGS				=	-Wall -Wextra -Werror -pedantic

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

all: BANNER

BANNER:
	@clear
	@cols=$$(tput cols);	\
		banner_width=51;		\
		indent=$$((($$cols - $$banner_width) / 2));		\
		echo "$$banner" | while IFS= read -r line; do	\
			printf "%*s%s\n" "$$indent" '' "$$line";	\
		done;	\

