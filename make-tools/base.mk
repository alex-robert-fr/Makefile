INCLUDES_DIR						=	$(_INCLUDES_DIR)
INCLUDES								=	$(foreach dir, $(INCLUDES_DIR), $(wildcard $(dir)/*.h))
SRCS_DIR								=	$(_SRCS_DIR)
SRCS										=	$(foreach dir, $(SRCS_DIR), $(wildcard $(dir)/*.c))

THEME										=	$(_THEME)
MAX_WIDTH								=	$(_MAX-WIDTH)
INDENT									=	$(_INDENT)

AUTHOR									= $(_AUTHOR)
PROJECT_NAME						=	$(_PROJECT_NAME)
GITHUB									=	$(_GITHUB)
PROJECT_VERSION					= $(_PROJECT_VERSION)
COMPILER								= $(shell $(CC) --version | head -n 1 | awk '{print toupper($$1), $$3}')
OS_VERSION							= $(shell lsb_release -si; lsb_release -sr)
BUILD_TYPE							= Debug
MAKEFILE_LAST_UPDATE		:= $(shell date -d "$(shell stat -c %y Makefile)" +'%Y-%m-%d %H:%M')


include ./make-tools/config/themes/$(THEME).mk
include ./make-tools/config/banner.mk
include ./make-tools/functions/display_banner.mk
include ./make-tools/functions/section/borders.mk
include ./make-tools/functions/section/columns.mk
include ./make-tools/functions/display_section.mk

.PHONY: all BANNER DASHBOARD DASHBOARD_RULE FILE_STRUCTURE FILE_STRUCTURE_RULE

all: INIT BANNER DASHBOARD DASHBOARD_RULE FILE_STRUCTURE FILE_STRUCTURE_RULE

INIT:
	@clear

BANNER:
	@printf "\n\n";
	$(call display_banner)

include ./make-tools/rules/dashboard_section/dashboard_rules.mk
DASHBOARD: DASHBOARD_RULE

include ./make-tools/rules/file_structure_section/file_structure_rules.mk
FILE_STRUCTURE: FILE_STRUCTURE_RULE
