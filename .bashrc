# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
 cd_func ()
 {
   local x2 the_new_dir adir index
   local -i cnt
 
   if [[ $1 ==  "--" ]]; then
     if [[ $2 ]]; then
	   str=$(dirs)
	   tmp=(${str})
	   goto=${tmp[$2]}
	   cd_func $goto
	 else
       dirs -v
	 fi
     return 0
   fi
 
   the_new_dir=$1
   [[ -z $1 ]] && the_new_dir=$home
 
   if [[ ${the_new_dir:0:1} == '-' ]]; then
     #
     # extract dir n from dirs
     index=${the_new_dir:1}
     [[ -z $index ]] && index=1
     adir=$(dirs +$index)
     [[ -z $adir ]] && return 1
     the_new_dir=$adir
   fi
 
   #
   # '~' has to be substituted by ${home}
   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="$HOME${the_new_dir:1}"
 
   #
   # now change to the new dir and add to the top of the stack
   pushd "${the_new_dir}" > /dev/null
   [[ $? -ne 0 ]] && return 1
   the_new_dir=$(pwd)
 
   #
   # trim down everything beyond 11th entry
   popd -n +11 2>/dev/null 1>/dev/null
 
   #
   # remove any other occurence of this dir, skipping the top of the stack
   for ((cnt=1; cnt <= 10; cnt++)); do
     x2=$(dirs +${cnt} 2>/dev/null)
     [[ $? -ne 0 ]] && return 0
     [[ ${x2:0:1} == '~' ]] && x2="${home}${x2:1}"
     if [[ "${x2}" == "${the_new_dir}" ]]; then
       popd -n +$cnt 2>/dev/null 1>/dev/null
       cnt=cnt-1
     fi
   done
 
   return 0
 }
 
 alias cd=cd_func


#=============================================================================
# Useful commands:
# ----------------
#
# CTRL + k                   Delete from cursor to end of line
# CTRL + u                   Delete from cursor to start of line
# sed 'x,yd' filename.txt    Output filename.txt deleting lines x to y
#

#=============================================================================
# Settings:
# ---------

# ctrl-space list all possible completions
bind '"\C- ":menu-complete'


#=============================================================================
# Bash profile aliases:
# ---------------------
alias bp_default_directory='cd /cygdrive/c/Dev/'
alias bp_tab_width='tabs 4'
alias bp_prompt="PS1='\e[31m[\t]\e[32m\w\e[0m\$ '"


#=============================================================================
# Functions:
# ----------

#
# Move all configuration from .bash_profile into .bashrc
#
bash_profile()
{
	bp_default_directory
	bp_tab_width
	bp_prompt
}

launch()
{
	if [[ $1 = 'metro' ]]; then
		cd /cygdrive/c/Dev/metro/metro
		npm start
	fi
}

#
# Convert a Windows file path to UNIX format.
#
bpath()
{
	bpath=$(echo $1 | sed -r 's_\\_/_'g)
	echo $bpath
}

#
# Get a file path converted from UNIX to Windows format
#
wpath()
{
	# Remove the cygdrive part and change 'c' to 'C:'.
	path=$(echo $1 | sed -r 's_/cygdrive/c_C:_')
	#echo $path
	
	# Change '/' to '/' and display.
	wpath=$(echo $path | sed -r 's_/_\\_'g)
	echo $wpath
}

#
# Get a file path converted from UNIX to Windows format of the specified file found in the current directory.
#
wpathrel()
{
	# Remove the cygdrive part and change 'c' to 'C:'.
	dir=$(pwd | sed -r 's_/cygdrive/([^/]+)_\1:_')

	# Remove the cygdrive part and change 'c' to 'C:'.
	path=$(echo $1 | sed -r 's_^.__')
	#echo $path
	
	# Change '/' to '\' and display.
	wpath=$(echo $dir$path | sed -r 's_/_\\_'g)
	echo $wpath
}

#
# wdir @@@
#
# Convert a given file path into the Windows format for it's containing directory.
#

#
# wwd
#
# Get the current working directory in a Windows file format
#
wwd()
{
    dir=$(pwd)
	wpath "$dir"
}

#
# getconfig
#
# Finds app settings and connection strings
#
getconfig ()
{
 find . -maxdepth 2 -type f -regex ".*/\(Web\|app\)\.config" |
 xargs grep "add \(name\|key\)=" --color=never |
 sed -r 's/.*add (key|name)="([^"]+)".*/\1: \2/' |
 sed -r 's/key(.*)/App Setting\1/' |
 sed -r 's/name(.*)/Connection String\1/'
}

#
# getconfigusages
#
# Finds unused app settings and connection strings
#
getconfigusages ()
{
 configs=$(find . -maxdepth 2 -type f -regex ".*/\(Web\|app\)\.config" |
 xargs grep "add \(name\|key\)=" --color=never |
 sed -r 's/.*add (key|name)="([^"]+)".*/\2/')
 
 configs=$(echo $configs | sed 's/ /\\|/g')
 configs=$(echo "("$configs")")
 configs=$(echo $configs | sed 's/()//')
 
 if [ $configs ]
 then
  csgrep $configs --color=always
 else
  echo "No config settings - need to be in a service directory or service project directory"
 fi
}

#
# open
#
# 0 args - opens Windows Explorer at the given location
# >0 args - runs the command from cmd
#
open ()
{
    if [ $1 ]
    then
        cmd /C $1
    else
	    explorer .
    fi
}

#
# weather
#
# 0 args - check the weather in paris
# 1 arg - check the weather in the specified location
#
weather ()
{
    if [ $1 ]
    then
        curl wttr.in/$1
    else
	    curl wttr.in/Oxford
    fi
}


#=============================================================================
# Aliases:
# --------

# Depends on the installation folder for Notepad++
alias np='/cygdrive/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe'
alias np='"/cygdrive/c/Program Files/Notepad++/notepad++.exe"'
alias npp="np"

alias hosts="np /cygdrive/c/Windows/System32/drivers/etc/hosts"

alias reload='. ~/.bashrc'
alias bashrc='np C:/cygwin64/$HOME/.bashrc'

alias grep='grep --color=always '

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

alias ls='ls -hF --color=tty'                 # classify files in colour

alias agrep='find . -type f -print0 | xargs -0 grep --color=always -n -i '
alias fgrep='find . -regex ".*\.\(vb\|cs\|asax\|aspx\|ashx\|ascx\|resx\|sql\|config\|cshtml\|html\|js\|py\)" -type f -print0 | xargs -0 grep --color=always -n -i '
alias vbgrep='find . -regex ".*\.vb" -type f -print0 | xargs -0 grep -n -i '
alias csgrep='find . -regex ".*\.cs" -type f -print0 | xargs -0 grep -n -i '
alias jsgrep='find . -regex ".*\.js" -type f -print0 | xargs -0 grep -n -i '
alias sqlgrep='find . -regex ".*\.sql" -type f -print0 | xargs -0 grep -n -i '
alias configgrep='find . -regex ".*\.config" -type f -print0 | xargs -0 grep -n -i '

alias dev='cd /cygdrive/c/Dev'

alias ahk='cd ~/AutoHotKey'

# Need to install and configure SSMSBoost
alias sqlhistory='cd /cygdrive/c/Dev/SQL/History/Execution'

alias metro='cd /cygdrive/c/Dev/metro/'
alias metrow='cd /cygdrive/c/Dev/metro/Metro.Website/'
alias metrowa='cd /cygdrive/c/Dev/metro/Metro.Website/src/app/'
alias metroa='cd /cygdrive/c/Dev/metro/Metro.Service/'
alias metroas='cd /cygdrive/c/Dev/metro/Metro.Service/Metro.Service/'

#alias filename='find /cygdrive/c/Dev/Dev.PP -regex ".*\.\(vb\|cs\|aspx\|ashx\|ascx\|js\|resx\|sql\|config\)" -type f | sed -r 's_.*/__' | grep -i '
#alias whereis='find /cygdrive/c/Dev/Dev.PP -regex ".*\.\(vb\|cs\|aspx\|ashx\|ascx\|js\|resx\|sql\|config\)" -type f | grep -i '
#alias afilename='find /cygdrive/c/Dev/Dev.PP -type f | sed -r 's_.*/__' | grep -i '
#alias awhereis='find /cygdrive/c/Dev/Dev.PP -type f | grep -i '


