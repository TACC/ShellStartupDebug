# SYNOPSIS
#
#   Summarizes configuration settings.
#
#   AX_SUMMARIZE_CONFIG([, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]]])
#
# DESCRIPTION
#
#   Outputs a summary of relevant configuration settings.
#

AC_DEFUN([AX_SUMMARIZE_CONFIG],
[

echo
echo '----------------------------------- SUMMARY ----------------------------------'
echo
echo "Package version............................." : shell_startup_debug-$SSDV
echo "Lua executable.............................." : $luaprog
echo "Prefix......................................" : $prefix
echo "Actual Install dir.........................." : $prefix/shell_startup_debug/$SSDV
echo
echo '------------------------------------------------------------------------------'
echo 

echo
echo Configure complete, now type \'make\' and then \'make install\'.
echo

])

