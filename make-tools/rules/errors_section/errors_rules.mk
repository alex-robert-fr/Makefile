define title_errors
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD) 💥  %-104s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "$(ERRORS_COUNTER) ERREURS trouvées"
endef

ERRORS_RULE:
	$(call title_errors)
	$(call border,bot,1,true)
	$(call display_logs,$(LOGS_DIR)$(ERRORS_LOGS),$(ERRORS_COLOR),$(ERRORS_COUNTER))
	$(call border,bot,1,true)
