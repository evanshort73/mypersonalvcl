# Voice commands for atom

<n> := 0..100;

# https://atom.io/packages/jumpy
grab dusty = TimeContext.Start("select", 30) {shift+right} {shift+enter};
dusty = If(TimeContext.Restart("select"), {shift+right}) {shift+enter};

tack <n> = {alt+$1};
tack tar = {ctrl+pgdn};
tack tar <n> = {ctrl+pgdn_$1};
tack lap = {ctrl+pgup};
tack lap <n> = {ctrl+pgup_$1};
tack new = {ctrl+n};
tack restore = {ctrl+shift+t};
venture = {ctrl+p};
treeview = {ctrl+shift+\};
run it = {f5};
last cursor = {alt+-};
next cursor = {alt+shift+-};
dowse = {ctrl+d};
dowse <n> = {ctrl+d_$1};
evict = {ctrl+k};
diffuse = {ctrl+/};
next error = {alt+shift+.};
