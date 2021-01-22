function vf --description 'Open a file for editing in Emacs from vterm'
    vterm_cmd find-file (realpath "$argv")
end

function vd --description 'Run dired on a directory from vterm'
    vterm_cmd dired (dirname (realpath "$argv"))
end

