dnl ######################################################################
dnl $Id: configure.ac,v 1.3 2004-01-21 22:13:29 mclay Exp $
dnl ######################################################################
dnl Process this file with autoconf to produce a configure script.
dnl This is for MGF

AC_INIT(Makefile.in)
AC_PREFIX_DEFAULT(/usr/local)
AC_SUBST(PATH_TO_LUA)
AC_SUBST(PATH_TO_GIT)
AC_PATH_PROG(PATH_TO_GIT, git, "")
AC_PATH_PROG(luaprog, lua, "")
if test x$luaprog = "x"; then
  echo The program "lua" must be in your path
  exit
fi

oldprog=$luaprog
while test -L $luaprog; do
  luaprog=$(readlink $luaprog)
  if test ${luaprog:0:1} != '/' ; then
     d=`dirname $oldprog`
     luaprog="$d/$luaprog"
     CWD=`pwd`
     d=`dirname $luaprog`
     b=`basename $luaprog`
     cd $d
     d=`pwd`
     luaprog="$d/$b"
     cd $CWD
  fi
  oldprog=$luaprog
done

printf "checking for valid Lua version"

LuaV=$( $luaprog -e 'print(_VERSION)' | sed -e 's/Lua //' )
SSDV=$( $luaprog -e 'v=require("src/Version"); s=v.name():gsub(" .*","");print(s)')


if test -n $PATH_TO_GIT -a -d .git ; then
  ssdV=$($PATH_TO_GIT describe)
else
  ssdV=$($luaprog -e 'v=require("src/Version"); s=v.git():gsub(" .*","");print(s)')
fi


IntLuaV=$( $luaprog  -e "_,_,M,m=_VERSION:gsub('Lua%s+',''):find('(%d+)%.(%d)'); print(math.floor(tonumber(M)*1000+tonumber(m)))")

if test $IntLuaV -lt 5001 -o $IntLuaV -gt 5003; then
  echo "Error: Shell_Startup_Debug requires versions 5.1,5.2, or 5.3, You have: $LuaV"
  exit 1
fi
  
echo "... $LuaV"

PATH_TO_LUA=$(dirname $luaprog)
WD=`pwd`

PATH_TO_LUA_DIR=${PATH_TO_LUA}/..

cd $PATH_TO_LUA_DIR

PATH_TO_LUA_DIR=`pwd`

cd $WD

cat > luaModuleAvailable << 'EOF'
function main()
   for i = 1, #arg do
      require(arg[[i]])
      if (not package.loaded[[arg[i]]]) then
         print (arg[[i]], "not available")
      end
   end
end

main()
EOF

printf "checking for lua modules: posix"

missingModules=""
for i in posix; do
  $luaprog luaModuleAvailable $i 2> /dev/null
  if test "$?" != 0 ; then
    missingModules="$missingModules $i"
  fi
done

rm luaModuleAvailable
if test -n "$missingModules" ; then
  echo ""
  echo ""
  echo "Error: The follow lua module(s) are missing: $missingModules"
  echo ""
  echo "You can not run Shell_Startup_Debug without: $missingModules"
  exit 1
fi

echo "... yes"

AC_OUTPUT(makefile:Makefile.in)

AX_SUMMARIZE_CONFIG
