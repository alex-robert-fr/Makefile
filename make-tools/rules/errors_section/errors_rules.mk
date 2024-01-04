define title_errors
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD) 💥  0 %-102s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "ERREURS trouvées"
endef

ERRORS_RULE:
	$(call title_errors)
	$(call border,bot,1,true)
