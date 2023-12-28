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

