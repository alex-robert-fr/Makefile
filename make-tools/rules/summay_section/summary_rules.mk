FILES_COMPILED=$$(expr $(TOTAL_FILES) - $(ERRORS_COUNTER))

define title_summary
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD) 📊  %-103s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "BUILD SUMMARY"
endef

define display_summary
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)     $(TITLE_COLOR)Files Compiled: $(WHITE)$(BOLD)%s\t$(WARNING_COLOR)Warnings: $(WHITE)$(BOLD)%s\t$(ERRORS_COLOR)Errors: $(WHITE)$(BOLD)%-56s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" $(FILES_COMPILED) $(WARNINGS_COUNTER) $(ERRORS_COUNTER)
endef

SUMMARY_RULE:
	$(call title_summary)
	$(call border,bot,1,true)
	$(call display_summary)
	$(call border,bot,1,false)
