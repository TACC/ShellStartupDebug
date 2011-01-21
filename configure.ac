dnl ######################################################################
dnl $Id: configure.ac,v 1.3 2004-01-21 22:13:29 mclay Exp $
dnl ######################################################################
dnl Process this file with autoconf to produce a configure script.
dnl This is for MGF

AC_INIT(Makefile.in)
AC_PREFIX_DEFAULT(/usr/local)
AC_SUBST(PATH_TO_LUA)
AC_PATH_PROG(luaprog, lua, "")
if test x$luaprog = "x"; then
  echo The program "lua" must be in your path
  exit
fi
PATH_TO_LUA=$(echo $luaprog | sed -e 's|/lua$||')

AC_OUTPUT(makefile:Makefile.in)

