# Display text in one columns
# $1	Texte
# $2	Padding
define one_col
	@printf "$(PRIMARY_ONE)%*s$(EMOJI_VERTICAL_LINE)$(RESET)%-$(2)b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" "$(INDENT)" "" "$(1)";
endef
#
# Display text in two columns
# $1	Texte
# $2	Padding
# $3	Texte
# $4	Padding
define two_col
	@printf "$(PRIMARY_ONE)%*s$(EMOJI_VERTICAL_LINE)$(RESET)%-$(2)b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)" "$(INDENT)" "" "$(1)";
	@printf "%-$(4)b$(PRIMARY_ONE)$(EMOJI_VERTICAL_LINE)$(RESET)\n" "$(3)";
endef
