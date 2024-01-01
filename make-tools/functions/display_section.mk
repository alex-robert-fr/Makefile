# Display section
# Schema file
define display_section
	@indent=$$((${MAX_WIDTH} / 20));																										\
	length=$$((${MAX_WIDTH} - ($$indent * 2)));																					\
	num_cols=0; 																																				\
	length_col=0;																																				\
	i=0;																																								\
	echo $(1) | while read line; do																											\
		if [ "$$i" -eq "0" ]; then																												\
			num_cols=$$((line)); 																														\
		elif [ "$$line" = "=" ] && [ "$$i" -eq "1" ]; then																\
			printf "$(PRIMARY_ONE)%*s$(EMOJI_TOP_LEFT_CORNER)" $$indent;										\
			x=1;																																						\
			length_col=$$(($$length / $$num_cols));																					\
			while [ "$$x" -le "$$num_cols" ]; do																						\
				printf "%0.s$(EMOJI_HORIZONTAL_LINE)" `seq 1 $$length_col`;										\
				if [ "$$x" -eq "$$num_cols" ]; then																						\
					printf "$(EMOJI_TOP_RIGHT_CORNER)$(RESET)"; 																\
				else																																					\
					printf "$(EMOJI_TOP_MIDDLE_CORNER)";																				\
				fi;																																						\
				x=$$((x+1));																																	\
			done;																																						\
		elif [ "$$(echo "$$line" | cut -f1 -d$$'\t' )" = "." ]; then											\
			printf "%*s" $$indent;																													\
			x=1;																																						\
			while [ "$$x" -le "$$num_cols" ]; do																						\
				all_cols=$$(printf "%s" "$$line" | cut -d$$'\t' -f"$$(($$x+1))");							\
				col_one=$$(printf "%s" "$$all_cols" | cut -d',' -f1);													\
				col_two=$$(printf "%s" "$$all_cols" | cut -d',' -f2);													\
				printf "$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)%s%s " "$$col_one" "$$col_two"; 																			\
				x=$$((x+1));																																	\
			done;																																						\
			printf "$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)";													\
		elif [ "$$line" = "-" ] && [ -n "$$i" ]; then																			\
			printf "$(PRIMARY_ONE)%*s$(EMOJI_MIDDLE_LEFT)" $$indent;										\
			x=1;																																						\
			while [ "$$x" -le "$$num_cols" ]; do																						\
				printf "%0.s$(EMOJI_HORIZONTAL_LINE)" `seq 1 $$(($$length / $$num_cols))`;		\
				if [ "$$x" -eq "$$num_cols" ]; then																						\
					printf "$(EMOJI_MIDDLE_RIGHT)$(RESET)"; 																\
				else																																					\
					printf "$(EMOJI_BOT_MIDDLE_CORNER)";																				\
				fi;																																						\
				x=$$((x+1));																																	\
			done;																																						\
		elif [ "$$line" = "=" ] && [ -n "$$i" ]; then																			\
			printf "$(PRIMARY_ONE)%*s$(EMOJI_BOT_LEFT_CORNER)" $$indent;										\
			x=1;																																						\
			while [ "$$x" -le "$$num_cols" ]; do																						\
				printf "%0.s$(EMOJI_HORIZONTAL_LINE)" `seq 1 $$(($$length / $$num_cols))`;		\
				if [ "$$x" -eq "$$num_cols" ]; then																						\
					printf "$(EMOJI_BOT_RIGHT_CORNER)$(RESET)"; 																\
				else																																					\
					printf "$(EMOJI_BOT_MIDDLE_CORNER)";																				\
				fi;																																						\
				x=$$((x+1));																																	\
			done;																																						\
		else																																							\
			printf "test";																																	\
		fi;																																								\
		printf "\n";																																			\
		i=$$(($$i+1));																																		\
	done;
endef
