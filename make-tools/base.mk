THEME										=	$(_THEME)
MAX_WIDTH								=	$(_MAX-WIDTH)
AUTHOR									= $(_AUTHOR)
PROJECT_NAME						=	$(_PROJECT_NAME)
GITHUB									=	$(_GITHUB)
PROJECT_VERSION					= $(_PROJECT_VERSION)
COMPILER								= $(shell $(CC) --version | head -n 1 | awk '{print toupper($$1), $$3}')
OS_VERSION							= $(shell lsb_release -si; lsb_release -sr)
BUILD_TYPE							= Debug
MAKEFILE_LAST_UPDATE		:= $(shell date -d "$(shell stat -c %y Makefile)" +'%Y-%m-%d %H:%M')


include ./make-tools/config/banner.mk
include ./make-tools/functions/display_banner.mk
include ./make-tools/functions/display_section.mk
include ./make-tools/functions/text_format.mk
include ./make-tools/config/themes/$(THEME).mk

.PHONY: all BANNER DASHBOARD

all: INIT BANNER DASHBOARD

INIT:
	@clear

BANNER:
	@printf "\n\n";
	$(call display_banner)
	@printf "\n\n";

DASHBOARD: 
	$(eval result=$(shell $(call column_length,Texte,50)))
	$(call display_section,"./make-tools/config/schemas/dashboard.txt")
