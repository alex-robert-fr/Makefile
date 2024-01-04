WARNINGS_COUNTER	=	0
ERRORS_COUNTER		=	0

define count_warnings
	$(eval WARNINGS_COUNTER=$$(shell wc -l < $(LOGS_DIR)$(WARNINGS_LOGS)))
endef

define count_errors
	$(eval ERRORS_COUNTER=$$(shell wc -l < $(LOGS_DIR)$(ERRORS_LOGS)))
endef

# Affiche les logs
# $1	Fichier de logs
# $2	Couleur
# $3	Compteur
define display_logs
	@logs_file=$(1);																																																																																								\
	if [ "$(3)" -le "0" ]; then	\
		printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%-109s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" " Aucun avertissement de compilation trouvé.";	\
	else	\
		while IFS= read -r line; do																																																																																			\
			file_line=$$(echo "$$line" | cut -d':' -f 1-3);																																																																								\
			message=$$(echo "$$line" | cut -d':' -f 5-);																																																																									\
			printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%-$$(($(MAX_WIDTH) + 27))b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" " $(PRIMARY_THREE)$(BOLD)$$file_line$(RESET)";	\
			first_line=true;																																																																																							\
			echo "$$message" | fold -s -w $$(($(MAX_WIDTH) - 10))| while IFS= read -r text_line; do 																																																			\
				trim_text_line=$$(echo "$$text_line" | awk '{$$1=$$1;print}');																																																															\
				letter_count=$$(echo -n "$$trim_text_line" | wc -m); 																																																																				\
				padding_size=$$(expr $(MAX_WIDTH) - $$letter_count); 																																																																				\
				if [ "$$first_line" = "true" ];	then																																																																												\
					printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)  $(2) $(RESET) %s%*s $(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "$$trim_text_line" $$(($$padding_size - 8)) "";\
					first_line=false;																																																																																					\
				else																																																																																												\
					printf "%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)     %-s%*s$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" $(INDENT) "" "$$trim_text_line" $$(expr $$padding_size - 7) ""; 					\
				fi;																																																																																													\
			done;																																																																																													\
		done < "$$logs_file";	\
	fi;
endef

LOGS_RULE:
	@grep "attention:" $(LOGS_DIR)$(TMP_LOGS) > $(LOGS_DIR)$(WARNINGS_LOGS) || true
	@grep "erreur:" $(LOGS_DIR)$(TMP_LOGS) > $(LOGS_DIR)$(ERRORS_LOGS) || true
	$(call count_warnings)
	$(call count_errors)
