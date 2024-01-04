define title_summary
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD) 📊  0 %-101s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "BUILD SUMMARY"
endef

SUMMARY_RULE:
	$(call title_summary)
	$(call border,bot,1,true)

