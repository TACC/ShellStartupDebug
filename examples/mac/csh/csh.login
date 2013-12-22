#!/bin/csh
# -*- shell-script -*-
# System-wide .login file for csh(1).

if ( ! $?__PATH_HELPER && -x /usr/libexec/path_helper ) then
    setenv __PATH_HELPER 1
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
        
