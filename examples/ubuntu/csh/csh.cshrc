#!/bin/csh
# -*- shell-script -*-

# /etc/csh.cshrc: system-wide .cshrc file for csh(1) and tcsh(1)

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
    DBG_ECHO "$DBG_INDENT$MY_NAME{"

    DBG_INDENT_FUNC up

    alias SOURCE 
########################################################################
#   End Shell Startup Debug
########################################################################


# by default, we want this to get set.
# Even for non-interactive, non-login shells.
test "`id -gn`" = "`id -un`" -a `id -u` -gt 99 
if ($status)  then
  umask 022
else
  umask 002
endif



if ($?tcsh && $?prompt) then

	bindkey "\e[1~" beginning-of-line # Home
	bindkey "\e[7~" beginning-of-line # Home rxvt
	bindkey "\e[2~" overwrite-mode    # Ins
	bindkey "\e[3~" delete-char       # Delete
	bindkey "\e[4~" end-of-line       # End
	bindkey "\e[8~" end-of-line       # End rxvt

	set autoexpand
	set autolist
	set prompt = "%U%m%u:%B%~%b%# "

        alias lf 'ls -aFC'
        alias m  'more'
        alias ll 'ls -alF'
        alias lt 'ls -altFr'
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
