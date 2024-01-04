define title_warning
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD) 🚧  %-104s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "$(WARNINGS_COUNTER) WARNINGS trouvées"
endef

WARNINGS_RULE:
	$(call title_warning)
	$(call border,bot,1,true)
	$(call display_logs,$(LOGS_DIR)$(WARNINGS_LOGS),$(WARNING_COLOR),$(WARNINGS_COUNTER))
	$(call border,bot,1,true)
