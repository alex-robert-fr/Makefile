CURRENT_LOADING_INDEX = 0
CURRENT_INDEX					= 0

# Animation de chargement
# params Nom_de_fichier_actuel
define moon_loading
	$(eval CURRENT_LOADING_INDEX=$(shell expr $(CURRENT_LOADING_INDEX) % $(words $(LOADING_EMOJIS)) + 1))
	@printf "\x1b[1K";
	@printf "\r%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET) $(word $(CURRENT_LOADING_INDEX), $(LOADING_EMOJIS)) $(BOLD)COMPILING:$(RESET) $(IMPORTANT_TEXT)%-93s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)" $(INDENT) "" "$(1)"
	@printf "\x1b[B";
endef

# Barre de progression
# params nombre_total_fichiers, width, current_index
define progress_bar
    $(eval TOTAL_FILES=$(1))
    $(eval MAX_BAR_LENGTH=$(2))
    $(eval CURRENT_INDEX=$(shell expr $(CURRENT_INDEX) + 1))
		$(eval PERCENT=$(shell expr $(CURRENT_INDEX) \* 100 / $(TOTAL_FILES)))
		$(eval FILLED_LENGTH := $(if $(filter $(CURRENT_INDEX),$(TOTAL_FILES)), $(MAX_BAR_LENGTH), $(shell expr $(CURRENT_INDEX) \* $(MAX_BAR_LENGTH) / $(TOTAL_FILES))))
    $(eval FILLED_PROGRESS_BAR=$(shell printf "%0.s█" $(shell seq 1 $(FILLED_LENGTH))))
		$(eval EMPTY_PROGRESS_BAR=$(shell if [ "$(CURRENT_INDEX)" -eq "$(TOTAL_FILES)" ]; then printf "%0.s" ""; else printf "%0.s░" $(shell seq 1 $(shell expr $(MAX_BAR_LENGTH) - $(FILLED_LENGTH))); fi))
    $(eval TEXT_PROGRESS_BAR=$(shell printf "[%s%s]" "$(FILLED_PROGRESS_BAR)" "$(EMPTY_PROGRESS_BAR)"))
    @printf "\r%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)    %s %-26s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)" $(INDENT) "" $(TEXT_PROGRESS_BAR) "$(PERCENT)%";
endef

COMPILING_RULE: $(OBJS)

%.o: %.c
	@if ! $(CC) -c $< -o $@ $(LIBS) $(CFLAGS) 2>> $(LOGS_DIR)$(TMP_LOGS);	then	\
		var=rien;\
	fi
	$(call moon_loading,$<)
	$(call progress_bar,$(words $(SRCS)),75)
	@printf "\n"
	$(call border,bot,1,true)
	@if [ "$(PERCENT)" != "100" ]; then	\
		printf "\x1b[3A";\
	fi;
