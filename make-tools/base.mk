THEME	=	$(_THEME)

include ./make-tools/config/banner.mk
include ./make-tools/functions/display_banner.mk
include ./make-tools/config/themes/$(THEME).mk

.PHONY: all BANNER

all: BANNER

BANNER:
	$(call display_banner)
