############ PROMPT ################
#export PS1="$BBLE \W $ $RS\n " After tesing activate this
PROMPT_COMMAND=build_prompt
build_prompt() {
  	EXIT=$?               # save exit code of last command
  	red='\[\e[0;31m\]'    # colors
  	green='\[\e[0;32m\]'
  	cyan='\[\e[1;36m\]'
  	reset='\[\e[0m\]'
	BG_GREEN="\[\e[42m\]"
	FG_BLACK="\[\e[30m\]"
	FMT_RESET="\[\e[0m\]"
	FG_GREEN="\[\e[32m\]"
	FG_BLUE="\[\e[34m\]"
	FG_CYAN="\[\e[36m\]"
	FG_GREY="\[\e[37m\]"
  	PS1='${debian_chroot:+($debian_chroot)}'  # begin prompt

  	if [ $EXIT != 0 ]; then  # add arrow color dependent on exit code
  	  PS1+="$red"
  	else
  	  PS1+="$green"
  	fi

	# \u este userul
	# \W este numele folderului local
	# $RS este color reset
  	PS1+="$RS$BBLE \u | \W "

	PS1+="${FMT_RESET}${FG_BLUE}"
	PS1+="\$(git branch 2> /dev/null | grep '^*' | colrm 1 2 | xargs -I BRANCH echo -n \"" # check if git branch exists
	PS1+="${BG_GREEN} " # end FILES container / begin BRANCH container
	PS1+="${FG_BLACK} BRANCH " # print current git branch
	PS1+="${FMT_RESET}${FG_GREEN}\")\n" # end last container (either FILES or BRANCH)
	PS1+="${FMT_RESET}➔ " # print prompt
	PS1+="${FMT_RESET}"
}

