# A Fisher plugin for Emacs vterm

If you use Fish shell and Emacs, you might also be interested in using
[vterm](https://github.com/akermu/emacs-libvterm), a fully-featured
terminal emulator based on libvterm. However, vterm requires some
shell-side configuration.

This is a [fisher](https://github.com/jorgebucaran/fisher) plugin that
loads the vterm configuration, if needed.

## Installation

You can install this plugin using this command:

```sh
fisher install pymander/vfish
```

## Emacs Configuration

This adds a number of commands to your vterm sessions.

- **vf** - Call `find-file` on a file.
- **vd** - Call `dired` on a directory.
- **vdiff** - Call `ediff` on two files.

In order to use these commands, however, you must configure
`vterm-eval-cmds` in Emacs. Insert this or something similar in your
startup file.

```elisp
(setq vterm-eval-cmds '(("find-file" find-file)
                        ("message" message)
                        ("vterm-clear-scrollback" vterm-clear-scrollback)
                        ("dired" dired)
                        ("ediff-files" ediff-files)))
```

## Issues

Currently, this doesn't work very well with
[tide](https://github.com/ilancosman/tide), which is a bummer, since
tide is the ultimate Fish prompt.
