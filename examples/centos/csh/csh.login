#!/bin/csh
# -*- shell-script -*-
# /etc/csh.login

# System wide environment and startup programs, for login setup

########################################################################
#   Begin Shell Startup Debug
########################################################################

    DBG_INDENT_FUNC init 

    set MY_NAME="/etc/csh.login"
    DBG_ECHO "$DBG_INDENT$MY_NAME{"
    DBG_ECHO "$DBG_INDENT  Login Shell: $SHELL"

########################################################################
#   End Shell Startup Debug
########################################################################

if ( $?PATH ) then
  #do not override user specified PATH
else
	if ( $uid == 0 ) then
		setenv PATH "/sbin:/usr/sbin:/usr/local/sbin:/bin:/usr/bin:/usr/local/bin"
	else
		setenv PATH "/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin"
	endif
endif

setenv HOSTNAME `/bin/hostname`
set history=1000

########################################################################
#   Begin Shell Startup Debug
########################################################################

    DBG_ECHO "$DBG_INDENT}"

########################################################################
#   End Shell Startup Debug
########################################################################
