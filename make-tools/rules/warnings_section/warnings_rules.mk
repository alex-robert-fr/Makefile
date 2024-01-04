define title_warning
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD) 🚧  0 %-102s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "WARNINGS trouvées"
endef

WARNINGS_RULE:
	$(call title_warning)
	$(call border,bot,1,true)
