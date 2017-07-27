# .bashrc

got here -5

#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------


if [ -f /etc/bashrc ] ; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi


echo got here -4

# User specific aliases and functions
#module load xilinx/vivado/2014.2
#module load openoffice/3.4.1
#module load modelsimse/10.3b


export myenv="work_linux"

################################################################################
#Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
################################################################################

echo got here -3

################################################################################
# User specific aliases and functions cd
alias m1='cd /M/VHDL/fpga_designs/mfitzgerald/my_working_copies/borealis_det_fpga/borealis_det_fpga/trunk/logic_design/src/afe_if/scancntl_if/'
alias m2='cd /M/VHDL/fpga_designs/mfitzgerald/my_working_copies/borealis_det_fpga/borealis_det_fpga/trunk/fpga/build/quartus10.0/'
alias pam1='cd /M/VHDL/fpga_designs/mfitzgerald/my_working_copies/borealis_pam_fpga/mf_r2854/'
alias pam2='cd //M/VHDL/fpga_designs/mfitzgerald/my_working_copies/borealis_pam_fpga/mf_r3345/'
alias st='cd /M/VHDL/fpga_designs/Surecom/svn/fpgas/scst2va_fpga/scst3/trunk/'
alias scht='cd /M/VHDL/fpga_designs/mfitzgerald/my_working_copies/hbst_schtester/'
alias st3sim='cd //M/VHDL/fpga_designs/mfitzgerald/my_working_copies/scst2va_fpga/scst3/trunk/sim/'
alias ptstsim='cd //M/VHDL/fpga_designs/mfitzgerald/my_working_copies/scst2va_fpga/ptst/trunk/sim'
alias ptss='cd //M/VHDL/fpga_designs/mfitzgerald/my_working_copies/surecom/fpgas/ptst_fpga/ptss_fpga/trunk/fpga_src/logic_design/src/'
alias c_one='cd /M/VHDL/fpga_designs/uelran/c_one_dma_invest'

echo got here -2

alias cdwc='cd /M/VHDL/fpga_designs/mfitzgerald/my_working_copies/'
alias cdmf='cd /M/VHDL/fpga_designs/mfitzgerald/'
alias Surecom='cd /M/VHDL/fpga_designs/Surecom/'
alias big_sim='cd /M/VHDL/fpga_designs/mfitzgerald/my_working_copies/apex/rtc/branches/big_sim_at_14544'
alias rfs='cd /M/VHDL/fpga_designs/mfitzgerald/my_working_copies/apex/rfs/sim'
alias viv='cd /M/VHDL/fpga_designs/mfitzgerald/vivado_tutorial/'
alias xil='cd /M/VHDL/fpga_designs/mfitzgerald/vivado_tutorial/'
alias mlo_v='module load xilinx/vivado/2014.3'
alias mlo_q='module load questasim/10.3b_1'
################################################################################


################################################################################
alias SV='source ~/new_svn.sh'
alias his='history'
alias h='history'
alias clr='clear'
alias cls='clear'
alias c='clear'
alias hgrep='history|grep --color'
alias agrep='alias|grep --color'
################################################################################


################################################################################
alias p='pwd'
################################################################################

echo got here -1

################################################################################
alias mt='grep -C 10 --color=always  'met.*timing' vivado.log'
alias ve='grep -C 10 --color=always  '^ERROR' vivado.log'
alias ve1='grep -m 1 -C 10 --color=always  '^ERROR' vivado.log'
################################################################################


################################################################################
# like a clipboard
alias scr='cat /M/VHDL/fpga_designs/mfitzgerald/scratch.txt'
################################################################################


################################################################################
# both recursively creates a directory and changes into that directory.
mkcd (){ mkdir -p "$*";cd "$*";}
################################################################################

echo got here 0

################################################################################
#
rl (){ 
myrl2=$myrl1
# 
myrl1=$myrl
#
myrl=$(readlink -f "$1"); 
#
echo -e "\$myrl\n$myrl" 
#
if [ ! -z "$myrl1" ]; then
echo -e "\$myrl1\n$myrl1" 
fi
#
if [ ! -z "$myrl2" ]; then
echo -e "\$myrl2\n$myrl2"
fi
}
################################################################################


################################################################################
url ()
{
myurl2=$myurl1
# 
myurl1=$myurl
#
myurl=$(svn info|gawk '/URL/{print $2}'|perl -pe 's/URL: //g')
#
#
echo -e "\$myurl\n$myurl" 
#
if [ ! -z "$myurl1" ]; then
echo -e "\$myurl1\n$myurl1" 
fi
#
if [ ! -z "$myurl2" ]; then
echo -e "\$myurl2\n$myurl2"
fi
}
################################################################################


################################################################################
# cdgrep(){
# alias|grep  -i --color  $1|grep -v ..
# }
# export -f cdgrep

#grep aliass for paths
cdg(){
#
  if [ "$1" != "" ]; then
      alias|grep cd|grep -i --color $1
      #echo "Positional parameter 1 contains something"
  else
      alias|grep cd|grep -v "\.\."
      #echo "Positional parameter 1 is empty"
  fi
#
}
export -f cdg
#
#grep aliases for paths that contain the string (case insensitive) 'Surecom'
cdgs(){
#
  if [ "$1" != "" ]; then
      alias|grep cd|grep -i --color Surecom|grep -i --color $1
      #echo "Positional parameter 1 contains something"
  else
      alias|grep cd|grep -v "\.\."|grep -i --color Surecom
      #echo "Positional parameter 1 is empty"
  fi
#
}
export -f cdgs
################################################################################


################################################################################
# Some shortcuts for different directory listings
alias lst="ls -alt|sed -r 's/^.*users[ ]*[0-9]{1,8} //'"
alias lstr="ls -altr|sed -r 's/^.*users[ ]*[0-9]{1,8} //'"
alias lsn="ls -al|sed -r 's/^.*users[ ]*[0-9]{1,8} //'"
#dirs only
alias lsd="ls -l --color=always| egrep '^d'"
#
#dirs last and together
alias lss="ls -al | sort -k1,1 -k9,9 -r |sed -r 's/^.*users[ ]*[0-9]{1,8} //'"
#
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls --color=auto --format=vertical'                              #
alias lsd='ls -d */'
#alias lh='ls -a | egrep "^\."'                #only dotfiles


################################################################################
#alias d='ls -l --time-style="long-iso" -h | egrep '^d' | awk '\''{print $1 "  " $6 "  " $7 "  " $8 " " $9}'\'''
alias d='ls -l  --color=always| egrep ^d'
alias dt='ls -l  --color=always| egrep ^d|tail'
alias t='ls -lrt --color=always'
alias tt='ls -lrt --color=always | tail'
alias l='ls -l --color=always'
alias s='ls  --color=always'
################################################################################

################################################################################


#
################################################################################
alias mlo='module load $1'
alias mli='module list'
alias mav='module available'
################################################################################


################################################################################
alias ss='source ~/start_sim'
alias SHOWLICENSE='lmutil lmstat -f msimviewer'
alias EW='emacs -geometry parameter when firing up emacs: emacs -geometry 160x160+20+30'
################################################################################


###############################################################################
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
###############################################################################


###############################################################################
#subversion helpers
#get rid of "vcs"
#
#using double quotes for the alias and single for the gawk run
# make it a function that does a bit mork alias url="svn info|gawk '/URL/{print $2}'|perl -pe 's/URL: //g'"
alias fixurl='svn info|gawk /URL/'\''{gsub(/URL: /,""); orig_url=$0;gsub(/vcs/,"chivcs.tmriusa.com");fixed_url=$0;svn_operation="svn switch --relocate";print  svn_operation,orig_url,fixed_url}'\''|bash'
#
#get a log file or 2,3,4,5,6,7 from the repo
alias log1='svn info|gawk /URL/'\''{gsub(/URL: /,"");print "svn log -vl 1 " $0}'\''|bash'
alias log2='svn info|gawk /URL/'\''{gsub(/URL: /,"");print "svn log -vl 2 " $0}'\''|bash'
alias log3='svn info|gawk /URL/'\''{gsub(/URL: /,"");print "svn log -vl 3 " $0}'\''|bash'
alias log4='svn info|gawk /URL/'\''{gsub(/URL: /,"");print "svn log -vl 4 " $0}'\''|bash'
alias log5='svn info|gawk /URL/'\''{gsub(/URL: /,"");print "svn log -vl 5 " $0}'\''|bash'
alias log6='svn info|gawk /URL/'\''{gsub(/URL: /,"");print "svn log -vl 6 " $0}'\''|bash'
alias log7='svn info|gawk /URL/'\''{gsub(/URL: /,"");print "svn log -vl 7 " $0}'\''|bash'
# Note on single quotes within a single quote string.
# I always just replace each imbedded single quote with the sequence: '\'' 
# (that is: quote backslash quote quote) which closes the string, 
# appends an escaped single quote and reopens the string.
###############################################################################


################################################################################
#dont put duplicate commands in history
export HISTIGNORE="&:ls:[bf]g:exit"

#allow C-s isearch at prompt
#for whatever reason, C-s gets trampled on by C-s (stop).
stty stop undef
################################################################################


################################################################################
export CDPATH='/etc/:/Configures/:./:~/:../:../../:~/:../../../:../../../../:../../../../../'
################################################################################


################################################################################
#home in path (append)
export PATH=$PATH:$HOME/mybin
#
################################################################################


################################################################################
#C-backspace deletes word
stty werase '^_'
################################################################################


################################################################################
# These functions will spit out the elements of a PATH, one per line.
# You can add these functions in your .profile or some other "rc" file,
# or use the nifty autoload feature of the ksh.
path ()
{
        echo $PATH | tr ':' '\n'
}
manpath ()
{
        echo $MANPATH | tr ':' '\n'
}
################################################################################


################################################################################
#stored in /mybin which is on the path
echo "reached before source acd_func.sh"
source acd_func.sh
################################################################################


################################################################################
#http://stackoverflow.com/questions/5687446/bash-custom-ps1-with-nice-working-directory-path
#better prompt
export MYPS='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF; else if (NF>3) print $1 "/" $2 "/.../" $NF; else print $1 "/.../" $NF; } else print $0;}'"'"')'
PS1='$(eval "echo ${MYPS}")$ '
################################################################################


################################################################################
 bind '"^T":kill-line'
################################################################################


# ################################################################################
# # are we an interactive shell?
# if [ "$PS1" ]; then

#   HOSTNAME=`hostname -s || echo unknown`

#   # add cd history function
#   [[ -f ${HOME}/bin/acd_func.sh ]] && . ${HOME}/bin/acd_func.sh
#   # make bash autocomplete with up arrow
#   bind '"\e[A":history-search-backward'
#   bind '"\e[B":history-search-forward'
#   ##################################
#   # BEG History manipulation section

#     # Don't save commands leading with a whitespace, or duplicated commands
#     export HISTCONTROL=ignoredups

#     # Enable huge history
#     export HISTFILESIZE=9999999999
#     export HISTSIZE=9999999999

#     # Ignore basic "ls" and history commands
#     export HISTIGNORE="ls:ls -al:ll:history:h:h[dh]:h [0-9]*:h[dh] [0-9]*"

#     # Save timestamp info for every command
#     export HISTTIMEFORMAT="[%F %T] ~~~ "

#     # Dump the history file after every command
#     shopt -s histappend
#     export PROMPT_COMMAND="history -a;"
#     [[ -f ${HOME}/bin/a_loghistory_func.sh ]] && . ${HOME}/bin/a_loghistory_func.sh

#     # Specific history file per host
#     export HISTFILE=$HOME/.history-$HOSTNAME

#     save_last_command () {
#         # Only want to do this once per process
#         if [ -z "$SAVE_LAST" ]; then
#             EOS=" # end session $USER@${HOSTNAME}:`tty`"
#             export SAVE_LAST="done"
#             if type _loghistory >/dev/null 2>&1; then
#                 _loghistory
#                 _loghistory -c "$EOS"
#             else
#                 history -a
#             fi
#             /bin/echo -e "#`date +%s`\n$EOS" >> ${HISTFILE}
#         fi
#     }
#     trap 'save_last_command' EXIT

#   # END History manipulation section
#   ##################################

#   # Preload the working directory history list from the directory history
#   if type -t hd >/dev/null && type -t cd_func >/dev/null; then
#       for x in `hd 20` `pwd`; do cd_func $x ; done
#   fi
# fi
# ################################################################################


 [[ -s /home/TMRIUSA/mfitzgerald/.autojump/etc/profile.d/autojump.sh ]] && source /home/TMRIUSA/mfitzgerald/.autojump/etc/profile.d/autojump.sh

################################################################################


################################################################################
# example of function use
mystat() {   svn st|grep -v \? ;}
export -f mystat
################################################################################

echo "reached end of .bashrc"
################################################################################
