#!/bin/csh
# -*- shell-script -*-

# System-wide .cshrc file for csh(1).

if ( ! $?__PATH_HELPER && -x /usr/libexec/path_helper ) then
    setenv __PATH_HELPER 1
    eval `/usr/libexec/path_helper -c`
endif

########################################################################
#   Begin Shell Startup Debug
########################################################################
    set nonomatch
    foreach i ( /etc/profile.d/*.CSH )
      source $i
    end

    unset i nonomatch 

    DBG_INDENT_FUNC init  # force the creation of the log file if $SHELL_STARTUP_DEBUG > 2

    set MY_NAME="/etc/csh.cshrc"
    DBG_ECHO "$DBG_INDENT$MY_NAME{"

    DBG_INDENT_FUNC up

########################################################################
#   End Shell Startup Debug
########################################################################

if ($?prompt) then
	set promptchars = "%#"
	if ($?tcsh) then
		set prompt = "[%m:%c3] %n%# "
	else
		set prompt = "[%m:%c3] `id -nu`%# "
	endif
endif

########################################################################
#   Begin Shell Startup Debug
########################################################################

    # Check if we aren't a loginshell and then source the startup files (*.csh)
    DBG_INDENT_FUNC clear  # This clears the echo function/alias if it exists

    DBG_RESET_DELTA_TIMER  # Reset the delta timer so that the time on the
                           # 1st first file sourced is just for it.
    set nonomatch
    foreach i ( /etc/profile.d/*.csh )
      if ( -r $i ) then
        DBG_ECHO "$DBG_INDENT$i{"
        source $i
        DBG_ECHO "$DBG_INDENT}"
      endif
    end
    unset i nonomatch

    DBG_INDENT_FUNC down
    DBG_ECHO "$DBG_INDENT}"

########################################################################
#   End Shell Startup Debug
########################################################################
    
