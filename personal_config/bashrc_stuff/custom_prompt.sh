
# Prompt Begenning
PR_START="${debian_chroot:+($debian_chroot)}"

# User
PR_USER="\[\033[01;32m\]\u@\h\[\033[00m\]"

# Time 
# PR_TIME="\@"
# PR_TIME="\$(date +%r)"
PR_TIME="\$(date +%I:%M:%S\%p)"
PR_TIME="\e[0;36m$PR_TIME\e[0m"

# Date 
PR_DATE="\$(date +%d/%m/%Y)"
PR_DATE="\e[2;36m$PR_DATE\e[0m"

# Datetime
PR_DATETIME="[$PR_TIME $PR_DATE]"
# PR_DATETIME="\e[0;33m$PR_DATETIME\e[0m"

# Git Branch
PR_GITBRANCH="(\$(git symbolic-ref --short HEAD 2>/dev/null))"
PR_GITBRANCH="\e[2;37m$PR_GITBRANCH\e[0m"

# Path
PR_PATH="\[\033[00m\]\[\033[01;34m\]\w/\[\033[00m\]"

# Combine everything
# PS1="$PS1$U1 $T1:$P1\n $ "
PR_LINE_1="$PR_START$PR_USER $PR_DATETIME:"
PR_LINE_2="$PR_GITBRANCH $PR_PATH"
PR_LINE_3="$ "
PS1="$PR_LINE_1\n$PR_LINE_2\n$PR_LINE_3"