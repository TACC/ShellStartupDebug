#!/bin/csh
# -*- shell-script -*-
# System-wide .login file for csh(1).

if ( -x /usr/libexec/path_helper ) then
	eval `/usr/libexec/path_helper -c`
endif

########################################################################
#   Begin Shell Startup Debug
########################################################################

    set MY_NAME="/etc/csh.login"
    if ( $?SHELL_STARTUP_DEBUG ) then
      DBG_ECHO "$DBG_INDENT$MY_NAME{"
    endif

    DBG_INDENT_FUNC down

    if ( $?SHELL_STARTUP_DEBUG ) then
      DBG_ECHO "$DBG_INDENT}"
    endif

########################################################################
#   Begin Shell Startup Debug
########################################################################
        
