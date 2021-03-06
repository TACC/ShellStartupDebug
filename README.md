# Shell Startup Debug

To trace the behavior of the startup scripts on your system use
shell_startup_debug.

Once installed, any user can create a file (`~/.init.sh` for bash, zsh, etc) and
(`~/.init.csh` for csh and tcsh) that will turn on the report of the startup
behavior.

Bash/Zsh users: Please put in `~/.init.sh`:

```
   export SHELL_STARTUP_DEBUG=1
```

Tcsh/Csh users: Please put in `~/.init.csh`:

```
   setenv SHELL_STARTUP_DEBUG 1
```

A bash user will see something like the following for output:

```
   /etc/profile{
      /etc/profile.d/bash_completion.sh{
      } Time = 0.0550                      (delta = 0.0550)
      /etc/profile.d/lmod.sh{
      } Time = 0.0770                      (delta = 0.0220)
      /etc/profile.d/modules.sh{
      } Time = 0.0997                      (delta = 0.0227)
      /etc/profile.d/z99_PrgEnv.sh{
      } Time = 0.2067                      (delta = 0.1030)
      /etc/bash.bashrc{
      } Time = 0.2338                      (delta = 0.0271)
    } Time = 0.2442                        (delta = 0.0104)
```

If you wish to create a file instead of writing to standard out, change the value for SHELL_STARTUP_DEBUG
to 3 in the bash or zsh shell: 

```
   export SHELL_STARTUP_DEBUG=3
```

There will be a separate file for each shell invocation.


For users wishing to track a particular environment variable through the startup process can do can add

```
   export SHELL_STARTUP_DEBUG_PRINT_LIST="var1:var2:var3"
```

to your ~/.init.sh file where var1 etc are the variables you wish to track. For example one might like
to track the PATH and MODULEPATH variables through startup:

```
   export SHELL_STARTUP_DEBUG_PRINT_LIST="PATH:MODULEPATH"
```

In this case the state of each variable is printed out after every '}' if it has a value.

See INSTALL for instructions.

