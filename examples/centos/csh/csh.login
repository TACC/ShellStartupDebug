#!/bin/csh
# -*- shell-script -*-
# /etc/csh.login

# System wide environment and startup programs, for login setup

########################################################################
#   Begin Shell Startup Debug
########################################################################

    DBG_INDENT_FUNC init 

    set MY_NAME="/etc/csh.login"
    if ( $?SHELL_STARTUP_DEBUG ) then
      echo "$DBG_INDENT$MY_NAME{"
      echo "$DBG_INDENT  Login Shell: $SHELL"
    endif

    DBG_INDENT_FUNC up

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

    ####################################################################
    # if ( -d /etc/profile.d ) then
    #         set nonomatch
    #         foreach i ( /etc/profile.d/*.csh )
    #                 if ( -r "$i" ) then
    # 	                        if ($?prompt) then
    # 	                              source "$i"
    # 	                        else
    # 	                              source "$i" >& /dev/null
    # 	                        endif
    #                 endif
    #         end
    #         unset i nonomatch
    # endif
    ####################################################################

    if ( -d /etc/profile.d ) then
      DBG_INDENT_FUNC clear  # This clears the echo function/alias if it exists
      set nonomatch
      foreach i ( /etc/profile.d/*.csh )
        if ( -r $i ) then
          if ( $?SHELL_STARTUP_DEBUG ) then
            DBG_ECHO "$DBG_INDENT$i{"
          endif
          if ($?prompt) then
                source "$i"
          else
                source "$i" >& /dev/null
          endif
          if ( $?SHELL_STARTUP_DEBUG ) then
            DBG_ECHO "$DBG_INDENT}"
          endif
        endif
      end
      unset i nonomatch
      DBG_INDENT_FUNC init   # This turns in back on.
    endif

    DBG_INDENT_FUNC down

    if ( $?SHELL_STARTUP_DEBUG ) then
      echo "$DBG_INDENT}"
    endif

########################################################################
#   End Shell Startup Debug
########################################################################
