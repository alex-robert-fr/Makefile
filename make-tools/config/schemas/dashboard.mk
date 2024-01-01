PLACEHOLDER_AUTHOR								= $(shell printf " $(TITLE_COLOR)%-16s$(YELLOW)" "Author:")
PLACEHOLDER_PROJECT_NAME					= $(shell printf " $(TITLE_COLOR)%-16s" "Project:")
PLACEHOLDER_GITHUB								= $(shell printf " $(TITLE_COLOR)%-16s" "Github:")
PLACEHOLDER_PROJECT_VERSION				= $(shell printf " $(TITLE_COLOR)%-16s" "Version:")
PLACEHOLDER_COMPILER							= $(shell printf " $(TITLE_COLOR)%-16s" "Compiler:")
PLACEHOLDER_OS										= $(shell printf " $(TITLE_COLOR)%-16s" "OS:")
PLACEHOLDER_BUILD_TYPE						= $(shell printf " $(TITLE_COLOR)%-16s" "Build Type:")
PLACEHOLDER_MAKEFILE_LAST_UPDATE	= $(shell printf " $(TITLE_COLOR)%-16s" "Last Update:")

FIELD_AUTHOR											= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(AUTHOR)")
FIELD_PROJECT_NAME								= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(PROJECT_NAME)")
FIELD_GITHUB											= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(GITHUB)")
FIELD_PROJECT_VERSION							= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(PROJECT_VERSION)")
FIELD_COMPILER										= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(COMPILER)")
FIELD_OS													= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(OS_VERSION)")
FIELD_BUILD_TYPE									= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(BUILD_TYPE)")
FIELD_MAKEFILE_LAST_UPDATE				= $(shell printf "$(YELLOW)$(ITALIC)%-34s" "$(MAKEFILE_LAST_UPDATE)")

define dashboard
2
=
.	$(PLACEHOLDER_AUTHOR),$(FIELD_AUTHOR)	$(PLACEHOLDER_PROJECT_NAME),$(FIELD_PROJECT_NAME),
.	$(PLACEHOLDER_GITHUB),$(FIELD_GITHUB)	$(PLACEHOLDER_PROJECT_VERSION),$(FIELD_PROJECT_VERSION),
.	$(PLACEHOLDER_COMPILER),$(FIELD_COMPILER)	$(PLACEHOLDER_OS),$(FIELD_OS),
.	$(PLACEHOLDER_BUILD_TYPE),$(FIELD_BUILD_TYPE)	$(PLACEHOLDER_MAKEFILE_LAST_UPDATE),$(FIELD_MAKEFILE_LAST_UPDATE),
-
endef
export dashboard
