define create_title_file_structure
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD)%-110s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "   FILE STRUCTURE";
endef

FILE_STRUCTURE_RULE:
	$(call create_title_file_structure)
	$(call border,bot,1,true)

