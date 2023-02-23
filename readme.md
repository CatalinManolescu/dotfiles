# Dotfiles

Based on [https://github.com/anishathalye/dotfiles](https://github.com/anishathalye/dotfiles) and powered by [https://git.io/dotbot](https://git.io/dotbot) .

## Override configuration by editing / creating these files

- `vim` : `~/.vimrc_local`
- `zsh` / `bash` : `~/.shell_local_before` run first
- `zsh` : `~/.zshrc_local_before` run before `.zshrc`
- `zsh` : `~/.zshrc_local_after` run after `.zshrc`
- `zsh` / `bash` : `~/.shell_local_after` run last
- `git` : `~/.gitconfig_local`
- `tmux` : `~/.tmux_local.conf`

### zsh config

**Hide user in prompt**

```bash
export RPR_SHOW_USER=false
```

**Hide hostname in prompt**

```bash
export RPR_SHOW_HOST=false
```

**Change arrow char in prompt**

```bash
export PR_ARROW_CHAR='>'
```

## dependencies

### enable mouse copy

For mouse copy you need to install `xclip` and `xsel` .

NOTE: in order to copy the selected text to clipboard you need to press the return key (before releasing the mouse buttton).

## usage

```bash
git clone https://github.com/CatalinManolescu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

NOTE: please change the git user name and email :)

## commands

### List tags for a docker image available on Docker hub

```bash
dtags <image> [<filter-key>[+<filter-key>[..]]]
```

Examples:

  - list all tags for nodejs

    ```bash
    dtags node
    ```

  - list all tags for nodejs that contain the key 'alpine' and 'lts'

    ```bash
    dtags node alpine+lts
    ```

### git status

```bash
git st
```

## tmux commands

Tmux prefix is `ctrl + a`

```bash
tmx                                     # start tmux and create new session
tmx <session-name>                      # start tmux and create new session and link to specified session
tmux a                                  # start tmux and attach to running session
tmux a -t <session-name>                # start tmux and attach to specified session
tmux ls                                 # list available sessions
tmux kill-session -t <session-name>     # kill session
```

### sessions

```text
:new                     # new session
s                        # list sessions
$                        # rename session
d                        # detach
:attach -c path          # set session working directory (used for new windows) 
```

### windows

```text
c                         # new window
,                         # rename window
w                         # list windows
&                         # kill window
.                         # move window (prompted for a new number)
:movew                    # move window to the next unused number
```

### panes

```text
v                         # vertical split (works also with %)
h                         # horizontal split (works also with ")
o                         # swap panes
q                         # show pane numbers
!                         # convert pane into window
x                         # kill pane
<space>                   # toggle between layouts
:setw synchronize-panes   # toggle pane synchronize (or use 'on' or 'off' to make it specific)
```

### misc

```text
?                         # list shortcuts
:                         # prompt
```

More commands at

- [https://tmuxcheatsheet.com/](https://tmuxcheatsheet.com/)
- <https://gist.github.com/MohamedAlaa/2961058>
