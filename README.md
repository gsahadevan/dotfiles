# gsahadevan dotfiles

**WARNING** Do not blindly use my settings unless you know what it does. Use at your own risk!!!

## Contents

- neovim config
- tmux config

## tmux keymaps

|Keymaps         															                                |Function                        
|-----------------------------------------------------------------------------|--------------------------
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>%</kbd>								                  | split current pane vertically
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>"</kbd>								                  | split current pane horizontally
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>x</kbd>								                  | close the current pane
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>z</kbd>								                  | toggle zoomed state of the current pane
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>q</kbd>								                  | shows pane numbers
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>h</kbd>								                  | select pane left
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>j</kbd>           			                  | select pane down
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>k</kbd>            			                | select pane up
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>l</kbd>                      			      | select pane right
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>Ctrl</kbd> + <kbd>h</kbd>                | resize pane left
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>Ctrl</kbd> + <kbd>j</kbd>                | resize pane down
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>Ctrl</kbd> + <kbd>k</kbd>                | resize pane up
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>Ctrl</kbd> + <kbd>l</kbd>                | resize pane right
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>, </kbd>								                  | rename current window
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>c</kbd>                                  | create window
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>1</kbd>								                  | move to window with number 1
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>p</kbd>								                  | move to previous window
|<kbd>Ctrl</kbd> + <kbd>t</kbd> <kbd>n</kbd>								                  | move to next window
|<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>&#8592;</kbd>					            | move current window to left
|<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>&#8594;</kbd>					            | move current window to right

## pomodoro timer

there are plenty of ways to implement the pomodoro timer. listed below some of the ideas that got archived.
```bash
# requires timer
# brew install caarlos0/tap/timer
alias meet30="timer 30m -n 'Meeting for 30 mins' && afplay /System/Library/Sounds/Funk.aiff"
alias rest10="timer 10m -n 'Break for 10 mins' && afplay /System/Library/Sounds/Funk.aiff"

# requires timer and terminal-notifier as well
# brew install caarlos0/tap/timer terminal-notifier
alias work="timer 20m -n 'Pomodoro - Work time' && terminal-notifier -message 'Pomodoro'\
     -title 'Work time is up! Take a break'\
     -sound Crystal"
alias rest="timer 05m -n 'Pomodoro - Rest time' && terminal-notifier -message 'Pomodoro'\
     -title 'Break is over! Get back to work'\
     -sound Crystal"
```

if you are using m1 or m2 mac you might have to use the below command.
```bash
arch -arm64 brew install 
```

there are some other ways to play sound on mac.
```bash
printf \\a
osascript -e beep
say done
afplay /System/Library/Sounds/Funk.aiff
```
