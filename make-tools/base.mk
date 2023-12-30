THEME				=	$(_THEME)
MAX_WIDTH		=	$(_MAX-WIDTH)

include ./make-tools/config/banner.mk
include ./make-tools/functions/display_banner.mk
include ./make-tools/config/themes/$(THEME).mk

.PHONY: all BANNER

all: INIT BANNER

INIT:
	@clear

BANNER:
	$(call display_banner)
