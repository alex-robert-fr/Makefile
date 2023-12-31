# Display section
# Schema file
define display_section
	@indent=$$((${MAX_WIDTH} / 20));																										\
	length=$$((${MAX_WIDTH} - ($$indent * 2)));																					\
	i=0;																																								\
	cat $(1) | while read line; do																											\
		if [ "$$line" = "=" ] && [ "$$i" -eq "0" ]; then																	\
			printf "%*s$(EMOJI_TOP_LEFT_CORNER)" $$indent;																	\
			printf "%0.s$(EMOJI_HORIZONTAL_LINE)" `seq 1 $$length`;													\
			printf "$(EMOJI_TOP_RIGHT_CORNER)";																							\
		elif [ "$$line" = "1" ]; then																											\
			printf "%*s" $$indent;																													\
			printf "$(EMOJI_VERTICAL_LINE)%-$${length}s$(EMOJI_VERTICAL_LINE)" " Hello world!";				\
		elif [ "$$line" = "=" ] && [ -n "$$i" ]; then																			\
			printf "%*s$(EMOJI_BOT_LEFT_CORNER)" $$indent;																	\
			printf "%0.s$(EMOJI_HORIZONTAL_LINE)" `seq 1 $$length`;													\
			printf "$(EMOJI_BOT_RIGHT_CORNER)";																							\
		else																																							\
			printf "test";																																	\
		fi;																																								\
		printf "\n";																																			\
		i=$$(($$i+1));																																		\
	done;
endef
