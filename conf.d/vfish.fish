# VTerm (https://github.com/akermu/emacs-libvterm#shell-side-configuration)
if test "vterm" = "$INSIDE_EMACS"
    function vterm_prompt_end;
        vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
    end

    # vterm does not work with tide, unfortunately
    if functions --query tide
        function fish_prompt -d "Write out the prompt"
            printf '%s@%s%s%s%s> ' (whoami) (hostname | cut -d . -f 1) \
                (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
        end
    end

    functions --copy fish_prompt vterm_old_fish_prompt
    function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
        # Remove the trailing newline from the original prompt. This is done
        # using the string builtin from fish, but to make sure any escape codes
        # are correctly interpreted, use %b for printf.
        printf "%b" (string join "\n" (vterm_old_fish_prompt))
        vterm_prompt_end
    end

    function clear
        vterm_printf "51;Evterm-clear-scrollback";
        tput clear;
    end

    function fish_title
        hostname
        echo ":"
        pwd
    end
end
