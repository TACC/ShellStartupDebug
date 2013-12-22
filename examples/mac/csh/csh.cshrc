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

    DBG_INDENT_FUNC init

    set MY_NAME="/etc/csh.cshrc"
    if ( $?SHELL_STARTUP_DEBUG ) then
      echo "$DBG_INDENT$MY_NAME{"
    endif

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

    set nonomatch
    foreach i ( /etc/profile.d/*.csh )
      if ( -r $i ) then
        if ( $?SHELL_STARTUP_DEBUG ) then
          DBG_ECHO "$DBG_INDENT$i{"
        endif
        source $i
        if ( $?SHELL_STARTUP_DEBUG ) then
          DBG_ECHO "$DBG_INDENT}"
        endif
      endif
    end
    DBG_INDENT_FUNC init   # This turns in back on.
    unset i nonomatch

    DBG_INDENT_FUNC down

    if ( $?SHELL_STARTUP_DEBUG ) then
      echo "$DBG_INDENT}"
    endif

########################################################################
#   End Shell Startup Debug
########################################################################
    
