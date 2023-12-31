# Display banner with color
define display_banner
	@num_line=$$(echo "$$banner" | wc -l);															\
	line_per_color=$$(($$num_line / 3));																\
	index_line=0;																												\
	length=$$(echo "$$banner" | head -n 1 | wc -m);											\
	indent=$$(expr \( ${MAX_WIDTH} - $$length + 1 \) / 2 );							\
	echo "$$banner" | while IFS= read -r line; do												\
		if [ "$$index_line" -lt "$$line_per_color" ]; then								\
			printf "%*s${PRIMARY_ONE}%s${RESET}\n" $$indent "" "$$line";		\
		elif [ "$$index_line" -lt $$(("$$line_per_color" * 2)) ]; then		\
			printf "%*s${PRIMARY_TWO}%s${RESET}\n" $$indent "" "$$line";		\
		else																															\
			printf "%*s${PRIMARY_THREE}%s${RESET}\n" $$indent "" "$$line";	\
		fi;																																\
		index_line=$$(($$index_line + 1));																\
	done;
endef
