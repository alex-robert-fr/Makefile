CC											=	$(_CC)
INCLUDES_DIR						=	$(_INCLUDES_DIR)
INCLUDES								=	$(foreach dir, $(INCLUDES_DIR), $(wildcard $(dir)/*.h))
SRCS_DIR								=	$(_SRCS_DIR)
SRCS										=	$(foreach dir, $(SRCS_DIR), $(wildcard $(dir)/*.c))
OBJS										:=	$(SRCS:.c=.o)
LIBS										=	$(_LIBS_DIR)
CFLAGS									=	$(_INCLUDES_FLAGS) $(_LIBS_FLAGS) -Wall -Wextra $(_CFLAGS)

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
MAKEFILE_LAST_UPDATE		= $(shell date -d "$(shell stat -c %y Makefile)" +'%Y-%m-%d %H:%M')

LOADING_EMOJIS 					= 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘
LOGS_DIR								=	./make-tools/tmp/
TMP_LOGS								=	logs.tmp
WARNINGS_LOGS						=	warnings.tmp
ERRORS_LOGS							=	errors.tmp

include ./make-tools/config/themes/$(THEME).mk
include ./make-tools/config/banner.mk
include ./make-tools/functions/display_banner.mk
include ./make-tools/functions/section/borders.mk
include ./make-tools/functions/section/columns.mk
include ./make-tools/functions/display_section.mk

.PHONY: all INIT INIT_LOGS BANNER DASHBOARD DASHBOARD_RULE FILE_STRUCTURE FILE_STRUCTURE_RULE PRE_CHECKS PRE_CHECKS_RULE COMPILING COMPILING_RULE LOGS LOGS_RULE WARNINGS WARNINGS_RULE ERRORS ERRORS_RULE SUMMARY SUMMARY_RULE CLEAR_LOGS

all: INIT INIT_LOGS  BANNER DASHBOARD FILE_STRUCTURE PRE_CHECKS COMPILING LOGS WARNINGS ERRORS SUMMARY CLEAR_LOGS 

clear:
	@rm -rf $(OBJS)

re: clear all

INIT:
	@clear

INIT_LOGS:
	@mkdir $(LOGS_DIR)

CLEAR_LOGS:
	@rm -rf $(LOGS_DIR)

BANNER:
	@printf "\n\n";
	$(call display_banner)

include ./make-tools/rules/dashboard_section/dashboard_rules.mk
DASHBOARD: DASHBOARD_RULE

include ./make-tools/rules/file_structure_section/file_structure_rules.mk
FILE_STRUCTURE: FILE_STRUCTURE_RULE

include ./make-tools/rules/pre-checks_section/pre-ckecks_rules.mk
PRE_CHECKS: PRE_CHECKS_RULE

include ./make-tools/rules/compiling_section/compiling_rules.mk
COMPILING: COMPILING_RULE

include ./make-tools/rules/logs_section/logs_rules.mk
LOGS: LOGS_RULE 

include ./make-tools/rules/warnings_section/warnings_rules.mk
WARNINGS: WARNINGS_RULE

include ./make-tools/rules/errors_section/errors_rules.mk
ERRORS: ERRORS_RULE

include ./make-tools/rules/summay_section/summary_rules.mk
SUMMARY: SUMMARY_RULE

