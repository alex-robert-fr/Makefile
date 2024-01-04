MAX_SIZE_FILE := $(shell echo $$(($(words $(SRCS)) > $(words $(INCLUDES)) ? $(words $(SRCS)) : $(words $(INCLUDES)))))

all:

define create_title_file_structure
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)$(BOLD)%-110s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "   FILE STRUCTURE";
endef

define list_files
	@for i in $(shell seq 1 $(MAX_SIZE_FILE)); do \
		if [ $$i -le $(words $(SRCS)) ]; then \
			elem1=`echo $(SRCS) | cut -d' ' -f$$i`; \
		else \
			elem1=" "; \
		fi; \
		if [ $$i -le $(words $(INCLUDES)) ]; then \
			elem2=`echo $(INCLUDES) | cut -d' ' -f$$i`; \
		else \
			elem2=" "; \
		fi; \
		printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%-54s%-54s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "   $$elem1" "   $$elem2";\
	done
endef

FILE_STRUCTURE_RULE:
	$(call create_title_file_structure)
	$(call border,bot,1,true)
	@printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%-98b%-98b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" " $(PRIMARY_ONE)$(BOLD) $(TITLE_COLOR)Sources Files:" " $(PRIMARY_ONE)$(BOLD) $(TITLE_COLOR)Includes Files:"
	$(call list_files)
	$(call border,bot,1,true)

