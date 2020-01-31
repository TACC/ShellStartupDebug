#!/bin/csh
# -*- shell-script -*-
# /etc/cshrc
#
# csh configuration for all shell invocations.

########################################################################
#   Begin Shell Startup Debug
########################################################################

    if (-e /etc/profile.d ) then
      set nonomatch
      foreach i ( /etc/profile.d/*.CSH )
        source $i;
      end;
      unset i nonomatch 
    endif

    DBG_INDENT_FUNC init

    set MY_NAME="/etc/csh.cshrc"
    DBG_ECHO "$DBG_INDENT$MY_NAME{"
    DBG_INDENT_FUNC up

########################################################################
#   End Shell Startup Debug
########################################################################

# By default, we want this to get set.
# Even for non-interactive, non-login shells.
# Current threshold for system reserved uid/gids is 200
# You could check uidgid reservation validity in
# /usr/share/doc/setup-*/uidgid file
if ($uid > 199 && "`id -gn`" == "`id -un`") then
    umask 002
else
    umask 022
endif

if ($?prompt) then
  if ($?tcsh) then
    set promptchars='$#'
    set prompt='[%n@%m %c]%# '
    # make completion work better by default
    set autolist
  else
    set prompt=\[$user@`hostname -s`\]\$\ 
  endif
endif

if ( $?tcsh ) then
	bindkey "^[[3~" delete-char
endif

bindkey "^R" i-search-back
set echo_style = both
set histdup = erase
set savehist = (1024 merge)

if ($?prompt) then
  if ($?TERM) then
    switch($TERM)
      case xterm*:
        if ($?tcsh) then
	  set prompt='%{\033]0;%n@%m:%c\007%}[%n@%m %c]%# '
        endif
        breaksw
      case screen:
        if ($?tcsh) then
          set prompt='%{\033_%n@%m:%c\033\\%}[%n@%m %c]%# '
        endif
        breaksw
      default:
        breaksw
    endsw
  endif
endif

setenv MAIL "/var/spool/mail/$USER"

# Check if we aren't a loginshell and do stuff if we aren't

########################################################################
#   Begin Shell Startup Debug
########################################################################


    ####################################################################
    # if (! $?loginsh) then
    #     if ( -d /etc/profile.d ) then
    #         set nonomatch
    #         foreach i ( /etc/profile.d/*.csh )
    #             if ( -r "$i" ) then
    #                 if ($?prompt) then
    #                     source "$i"
    #                 else
    #                     source "$i" >&/dev/null
    #                 endif
    #             endif
    #         end
    #         unset i nonomatch
    #     endif
    # endif
    ####################################################################

    set nonomatch

    DBG_RESET_DELTA_TIMER  # Reset the delta timer so that the time on the
                           # 1st first file sourced is just for it.
    foreach i ( /etc/profile.d/*.csh )
      if ( -r $i ) then
        DBG_ECHO "$DBG_INDENT$i{"
        if ($?prompt) then
            source "$i"
        else
            source "$i" >&/dev/null
        endif
        DBG_ECHO "$DBG_INDENT}"
      endif
    end
    unset i nonomatch

    DBG_INDENT_FUNC down

    DBG_ECHO "$DBG_INDENT}"
    endif

########################################################################
#   End Shell Startup Debug
########################################################################
