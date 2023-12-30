# Display banner with color
define display_banner
	@num_line=$$(echo "$$banner" | wc -l);				\
	line_per_color=$$(($$num_line / 3));					\
	line_index=0;																	\
	echo "$$banner" | while IFS= read -r line; do	\
		printf "$(PRIMARY_ONE)%s$(RESET)\n" "$$line";											\
	done;
endef
