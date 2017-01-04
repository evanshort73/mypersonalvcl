# Voice commands for notepad++
<n> := 0..100;

tack <n> = {ctrl+numkey$1};
tack tar = {ctrl+pgdn};
tack tar <n> = {ctrl+pgdn_$1};
tack lap = {ctrl+pgup};
tack lap <n> = {ctrl+pgup_$1};
tack new = {ctrl+n};
tack restore = {ctrl+shift+t};
reinstate = {ctrl+y};
grab word = {ctrl+f}{esc} TimeContext.Start("select", 40, "noop()");
