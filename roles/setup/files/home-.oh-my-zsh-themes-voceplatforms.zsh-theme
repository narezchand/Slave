WHOAMI=$(whoami)

if [[ "${WHOAMI}" == "root" ]]; then
PROMPT=$'%{$fg_bold[white]%}%n%{$fg_bold[grey]%}@%{$fg_bold[green]%}%M:%{$reset_color%}%{$fg[blue]%}%/%{$reset_color%}
%{$fg_bold[red]%}# %{$reset_color%} '
else
PROMPT=$'%{$fg_bold[white]%}%n%{$fg_bold[grey]%}@%{$fg_bold[green]%}%M:%{$reset_color%}%{$fg[blue]%}%/%{$reset_color%}
%{$fg_bold[grey]%}➜ %{$reset_color%} '
fi

PROMPT2="%{$fg_blod[black]%}%_> %{$reset_color%}"
