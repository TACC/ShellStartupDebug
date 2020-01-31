#!/bin/csh
# -*- shell-script -*-
#

########################################################################
#   Begin Shell Startup Debug
########################################################################
    set MY_NAME="/etc/csh.login"
    DBG_ECHO "$DBG_INDENT$MY_NAME{"
    DBG_ECHO "$DBG_INDENT  Login Shell: $SHELL"

    # /etc/csh.login: system-wide .login file for csh(1) and tcsh(1)

    ###################################################################
    # if (-e /etc/csh/login.d && `/bin/ls /etc/csh/login.d` != "") then
    #   foreach FILE (`/bin/ls /etc/csh/login.d/*`)
    #     source $FILE;
    #   end
    # endif
    ###################################################################

    # allow for other packages/system admins to customize the shell environment
    set nonomatch
    DBG_RESET_DELTA_TIMER  # Reset the delta timer so that the time on the
                           # 1st first file sourced is just for it.
    foreach i (/etc/csh/login.d/*)
      if ( -r $i ) then
        DBG_ECHO "$DBG_INDENT$i{"
        source $i;
        DBG_ECHO "$DBG_INDENT}"
      endif
    end
    unset i nonomatch

    DBG_INDENT_FUNC down
    DBG_ECHO "$DBG_INDENT}"

########################################################################
#   End Shell Startup Debug
########################################################################
