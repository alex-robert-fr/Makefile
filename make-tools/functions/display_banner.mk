# Display banner with color
define display_banner
	@num_line=$$(echo "$$banner" | wc -l);							\
	line_per_color=$$(($$num_line / 3));								\
	line_index=0;																				\
	length=$$(echo "$$banner" | head -n 1 | wc -m);			\
	indent=$$(expr \( ${MAX_WIDTH} - $$length + 2 \) / 2 );	\
	echo "$$banner" | while IFS= read -r line; do				\
		printf "%*s${PRIMARY_ONE}%s${RESET}\n" $$indent "" "$$line";			\
	done;
endef
