#	Display borders sections
#	$1	top | bot => Type de bordure
#	$2	Nombre de colonnes
#	$3	true | false => Is middle line
define border
	@indent=$(INDENT);																														\
	length=$$((${MAX_WIDTH} - $$((1 + $(2)))));																		\
	num_cols="$(2)";																															\
	length_col=$$(($$length / $$num_cols));																				\
	mod_length_col=$$(($$length % $$num_cols));																		\
	if [ "$(1)" = "top" ]; then 																									\
		left_corner="$(EMOJI_TOP_LEFT_CORNER)";																			\
		right_corner="$(EMOJI_TOP_RIGHT_CORNER)";																		\
		middle="$(EMOJI_TOP_MIDDLE_CORNER)";																				\
	elif [ "$(1)" = "bot" ]; then																									\
		left_corner="$(EMOJI_BOT_LEFT_CORNER)";																			\
		right_corner="$(EMOJI_BOT_RIGHT_CORNER)";																		\
		middle="$(EMOJI_BOT_MIDDLE_CORNER)";																				\
	fi;																																						\
	if [ "$(3)" = "true" ]; then																									\
		left_corner="$(EMOJI_MIDDLE_LEFT)";																					\
		right_corner="$(EMOJI_MIDDLE_RIGHT)";																				\
	fi;																																						\
	printf "$(PRIMARY_ONE)%*s$$left_corner" $$indent;															\
	x=0;																																					\
	while [ "$$x" -lt "$$num_cols" ];	do																					\
		printf "%0.s$(EMOJI_HORIZONTAL_LINE)" `seq 1 $$length_col`;									\
		if [ "$$num_cols" -gt "1" ] && [ "$$x" -lt "$$(($$num_cols-1))" ] ;	then		\
			printf "$$middle";																												\
		fi;																																					\
		x=$$((x+1));																																\
	done;																																					\
	if [ "$$num_cols" -gt "1" ] && [ "$$mod_length_col" -gt "0" ];	then					\
		printf "%0.s$(EMOJI_HORIZONTAL_LINE)" `seq 1 $$mod_length_col`;							\
	fi;																																						\
	printf "$$right_corner$(RESET)\n";
endef

