SECTION_TITLE					=	$(shell printf "$(BOLD)%-106s$(RESET)" "   FILE STRUCTURE")
COLUMN_LEFT_TITLE			=	$(shell printf "$(PRIMARY_ONE)$(BOLD)  $(TITLE_COLOR)%-50s$(RESET)" " Sources Files:")
COLUMN_RIGHT_TITLE		=	$(shell printf "$(PRIMARY_ONE)$(BOLD)  $(TITLE_COLOR)%-48s$(RESET)" " Includes Files:")

define file_structure
1
.	$(SECTION_TITLE),
-
.	$(COLUMN_LEFT_TITLE),$(COLUMN_RIGHT_TITLE),
=
endef
export file_structure

