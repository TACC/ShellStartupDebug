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
    DBG_ECHO "$DBG_INDENT$MY_NAME{"

    DBG_INDENT_FUNC down

    DBG_ECHO "$DBG_INDENT}"

########################################################################
#   Begin Shell Startup Debug
########################################################################
        
