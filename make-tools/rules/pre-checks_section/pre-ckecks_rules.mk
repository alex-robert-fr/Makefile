define create_title_pre_checks
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD)%-110s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" " 📋  PRE-CHECKS";
endef

define list_checks
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%-135b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "     $(VALIDATION)✔$(RESET) Headers verified.";
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%-135b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "     $(VALIDATION)✔$(RESET) Source files verified.";
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%-135b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "     $(VALIDATION)✔$(RESET) Libraries up to date.";
endef

PRE_CHECKS_RULE:
	$(call create_title_pre_checks)
	$(call border,bot,1,true)
	$(call list_checks)
	$(call border,bot,1,true)
