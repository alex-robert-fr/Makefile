_CC											=	gcc
_AUTHOR									=	0x7c00
_PROJECT_NAME						=	Makefile
_GITHUB									=	https://github.com/alex-robert-fr
_PROJECT_VERSION				=	1.0.0
_INCLUDES_DIR						=	src/includes
_SRCS_DIR								=	src src/engine src/entities src/map src/window
_LIBS_DIR								=	-Lsrc/lib/minilibx-linux
_INCLUDES_FLAGS					=	-Isrc/includes -Isrc/lib/minilibx-linux
_LIBS_FLAGS							=	
_CFLAGS									= 

_THEME									= default
_MAX-WIDTH							= 110
_INDENT									= 3

# Emoji
EMOJI_HORIZONTAL_LINE		=	"═"
EMOJI_VERTICAL_LINE			=	"║"
EMOJI_TOP_LEFT_CORNER		=	"╔"
EMOJI_TOP_MIDDLE_CORNER	=	"╦"
EMOJI_BOT_MIDDLE_CORNER	=	"╩"
EMOJI_MIDDLE_LEFT				=	"╠"
EMOJI_MIDDLE_RIGHT			=	"╣"
EMOJI_MIDDLE_MIDDLE			=	"╬"
EMOJI_TOP_RIGHT_CORNER	=	"╗"
EMOJI_BOT_LEFT_CORNER		=	"╚"
EMOJI_BOT_RIGHT_CORNER	=	"╝"

include ./make-tools/base.mk
