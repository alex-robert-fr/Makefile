define create_dashboard
	@printf "$(PRIMARY_ONE)%*s$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-34s" $(INDENT) "" "Author:" "$(AUTHOR)";
	@printf "$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-35s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" "Project Name:" "$(PROJECT_NAME)";
	@printf "$(PRIMARY_ONE)%*s$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-34s" $(INDENT) "" "GitHub:" "$(GITHUB)";
	@printf "$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-35s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" "Version:" "$(PROJECT_VERSION)";
	@printf "$(PRIMARY_ONE)%*s$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-34s" $(INDENT) "" "Compiler:" "$(COMPILER)";
	@printf "$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-35s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" "OS:" "$(OS_VERSION)";
	@printf "$(PRIMARY_ONE)%*s$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-34s" $(INDENT) "" "Build Type:" "$(BUILD_TYPE)";
	@printf "$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(TITLE_COLOR) • %-16s$(YELLOW)$(ITALIC)%-35s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" "Last Update:" "$(MAKEFILE_LAST_UPDATE)";
endef

DASHBOARD_RULE:
	$(call border,top,2)
	$(call create_dashboard)
	$(call border,bot,2,true)
