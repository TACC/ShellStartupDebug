#!/bin/csh
# -*- shell-script -*-
#

########################################################################
#   Begin Shell Startup Debug
########################################################################
    set MY_NAME="/etc/csh.login"
    if ( $?SHELL_STARTUP_DEBUG ) then
      DBG_ECHO "$DBG_INDENT$MY_NAME{"
      DBG_ECHO "$DBG_INDENT  Login Shell: $SHELL"
    endif


    # /etc/csh.login: system-wide .login file for csh(1) and tcsh(1)

    ###################################################################
    # if (-e /etc/csh/login.d && `/bin/ls /etc/csh/login.d` != "") then
    #   foreach FILE (`/bin/ls /etc/csh/login.d/*`)
    #     source $FILE;
    #   end
    # endif
    ###################################################################

    # allow for other packages/system admins to customize the shell environment
    if (-e /etc/csh/login.d && `/bin/ls /etc/csh/login.d` != "") then
      foreach FILE (`/bin/ls /etc/csh/login.d/*`)
        if ( $?SHELL_STARTUP_DEBUG ) then
           DBG_ECHO "$DBG_INDENT$FILE{"
        endif
        source $FILE;
        if ( $?SHELL_STARTUP_DEBUG ) then
           DBG_ECHO "$DBG_INDENT}"
        endif
      end
    endif

    DBG_INDENT_FUNC down

    if ( $?SHELL_STARTUP_DEBUG ) then
      DBG_ECHO "$DBG_INDENT}"
    endif

########################################################################
#   End Shell Startup Debug
########################################################################
