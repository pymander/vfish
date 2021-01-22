# VTerm (https://github.com/akermu/emacs-libvterm#shell-side-configuration)
if test 'vterm' = "$INSIDE_EMACS" \
    -a -n "$EMACS_VTERM_PATH" \
    -a -f "$EMACS_VTERM_PATH/etc/emacs-vterm.fish"

    # vterm does not work with tide, unfortunately
    if functions --query tide
        function fish_prompt -d "Write out the prompt"
            printf '%s@%s%s%s%s> ' (whoami) (hostname | cut -d . -f 1) \
                (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
        end
    end

    source "$EMACS_VTERM_PATH/etc/emacs-vterm.fish"
end
