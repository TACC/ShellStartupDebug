#!/bin/bash
# -*- shell-script -*-
# System-wide .bashrc file for interactive bash(1) shells.

# Source the debug indent functions *.SH

########################################################################
#   Begin Shell Startup Debug
########################################################################

    if ! shopt -q login_shell; then
      for i in /etc/profile.d/*.SH; do
        if [ -r $i ]; then
          . $i
        fi
      done
      unset i
      DBG_INDENT_FUNC init # force the creation of the log file if $SHELL_STARTUP_DEBUG > 2
    fi

    MY_NAME="/etc/bash.bashrc"
    DBG_ECHO "$DBG_INDENT$MY_NAME{"

    DBG_INDENT_FUNC up

    if ! shopt -q login_shell; then
      for i in /etc/profile.d/*.sh; do
        if [ -r $i ]; then
          DBG_ECHO "$DBG_INDENT$i{"
          . $i
          DBG_ECHO "$DBG_INDENT}"
        fi
      done
      unset i
     fi
    DBG_INDENT_FUNC down

    # To enable the settings / commands in this file for login shells as well,
    # this file has to be sourced in /etc/profile.

    ###################################################################
    #  [ -z "$PS1" ] && return
    ###################################################################


    # If not running interactively, don't do anything
    if [ -z "$PS1" ]; then
      DBG_ECHO "$DBG_INDENT}"
      return
    fi  

########################################################################
#   End Shell Startup Debug
########################################################################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
[ "$PS1" = "\\s-\\v\\\$ " ] && PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ] && [ ! -e "$HOME/.hushlogin" ] ; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

########################################################################
#   Begin Shell Startup Debug
########################################################################

    DBG_ECHO "$DBG_INDENT}"

########################################################################
#   End Shell Startup Debug
########################################################################


