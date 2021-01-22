function vterm_command --description 'Run an Emacs command from those found in vterm-eval-cmds.'
    set -l vterm_elisp ()
    for arg in $argv
        set -a vterm_elisp (printf '"%s" ' (string replace -a -r '([\\\\"])' '\\\\\\\\$1' $arg))
    end
    vterm_printf '51;E'(string join '' $vterm_elisp)
end

function vf --description 'Open a file for editing in Emacs from vterm'
    vterm_command find-file (realpath "$argv")
end

function vd --description 'Run dired on a directory from vterm'
    vterm_command dired (dirname (realpath "$argv"))
end

