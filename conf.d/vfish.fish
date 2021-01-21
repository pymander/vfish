# VTerm (https://github.com/akermu/emacs-libvterm#shell-side-configuration)
function _vfish_install --on-event vfish_install
    if [ "vterm" == $INSIDE_EMACS ]
        function vterm_printf;
            if [ -n "$TMUX" ]
                # tell tmux to pass the escape sequences through
                # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
                printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
            else if string match -q -- "screen*" "$TERM"
                # GNU screen (screen, screen-256color, screen-256color-bce)
                printf "\eP\e]%s\007\e\\" "$argv"
            else
                printf "\e]%s\e\\" "$argv"
            end
        end

        function vterm_prompt_end;
            vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
        end

        # vterm does not work with tide, unfortunately
        if function --query tide
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
end

function _vfish_uninstall --on-event vfish_uninstall
    if functions --query vterm_old_fish_prompt
        functions --copy vterm_old_fish_prompt fish_prompt
    end
end
