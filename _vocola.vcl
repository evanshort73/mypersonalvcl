# Global voice commands

# numbers
<n> := 0..100;
bay <n> = $1;

# letters
<a> :=
  ( adder = a
  | bird = b
  | cow = c
  | duck = d
  | elk = e
  | fish = f
  | goat = g
  | horse = h
  | imp = i
  | jackal = j
  | kiwi = k
  | loon = l
  | moose = m
  | newt = n
  | orca = o
  | pig = p
  | quail = q
  | rhino = r
  | sheep = s
  | turtle = t
  | umber = u
  | vole = v
  | wolf = w
  | ox = x
  | yak = y
  | zebra = z
  );
<a> = If(TimeContext.Restart("capslock"), {shift+$1}, $1);
bay <a> = {shift+$1};
bay lock = TimeContext.Start("capslock", 40, "noop()");
bay unlock = If(TimeContext.Restart("capslock", 0), "", "");

grab = TimeContext.Start("select", 40, "noop()");
control grab = TimeContext.Start("controlselect", 40, "noop()");
jetsam = If(TimeContext.Restart("select", 0), "", "") If(TimeContext.Restart("controlselect", 0), "", "");

# arrows
lap =
  If(TimeContext.Restart("select"),
     {shift+left},
     If(TimeContext.Restart("controlselect"),
        {ctrl+left},
        {left}));
tar =
  If(TimeContext.Restart("select"),
     {shift+right},
     If(TimeContext.Restart("controlselect"),
        {ctrl+right},
        {right}));
wick =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeUp_5}),
     If(TimeContext.Restart("select"),
        {shift+up},
        If(TimeContext.Restart("controlselect"),
           {ctrl+up},
           {up})));
bear =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeDown_5}),
     If(TimeContext.Restart("select"),
        {shift+down},
        If(TimeContext.Restart("controlselect"),
           {ctrl+down},
           {down})));

# repeat arrows
lap <n> =
  If(TimeContext.Restart("select"),
     {shift+left_$1},
     If(TimeContext.Restart("controlselect"),
        {ctrl+left_$1},
        {left_$1}));
tar <n> =
  If(TimeContext.Restart("select"),
     {shift+right_$1},
     If(TimeContext.Restart("controlselect"),
        {ctrl+right_$1},
        {right_$1}));
wick <n> =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeUp_ Eval("$1 * 5")}),
     If(TimeContext.Restart("select"),
        {shift+up_$1},
        If(TimeContext.Restart("controlselect"),
           {ctrl+up_$1},
           {up_$1})));
bear <n> =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeDown_ Eval("$1 * 5")}),
     If(TimeContext.Restart("select"),
        {shift+down_$1},
        If(TimeContext.Restart("controlselect"),
           {ctrl+down_$1},
           {down_$1})));

# batch arrows
lapsy = If(TimeContext.Restart("select"), {ctrl+shift+left}, {ctrl+left}{shift+ctrl+right});
tarzy = If(TimeContext.Restart("select"), {ctrl+shift+right}, {ctrl+right}{shift+ctrl+left});
wicksy = {end}{up}{end}{shift+down}{shift+end} If(TimeContext.Restart("select", 0), "", "");
bearsy = {end}{shift+home} If(TimeContext.Restart("select", 0), "", "");

# repeat batch arrows
lapsy <n> = If(TimeContext.Restart("select"), {ctrl+shift+left_$1}, {ctrl+left_$1}{shift+ctrl+right_$1});
tarzy <n> = If(TimeContext.Restart("select"), {ctrl+shift+right_$1}, {ctrl+right_$1}{shift+ctrl+left_$1});
wicksy <n> = {end}{up_$1}{end}{shift+down_$1}{shift+end} If(TimeContext.Restart("select", 0), "", "");
bearsy <n> = {end}{down_ Eval("$1 - 1")}{end}{shift+up_ Eval("$1 - 1")}{shift+end}{shift+home} If(TimeContext.Restart("select", 0), "", "");

# long-range arrows
lappy = If(TimeContext.Restart("select"), {shift+home}, {home});
taree = If(TimeContext.Restart("select"), {shift+end}, {end});
wiki = If(TimeContext.Restart("select"), {shift+pgup}, {pgup});
berry = If(TimeContext.Restart("select"), {shift+pgdn}, {pgdn});
wiki <n> = If(TimeContext.Restart("select"), {shift+pgup_$1}, {pgup_$1});
berry <n> = If(TimeContext.Restart("select"), {shift+pgdn_$1}, {pgdn_$1});

# repeatable keys
<repeatable> :=
  ( levy = tab
  | lever = shift+tab
  | burn = del
  | swipe = backspace
  | nudge = space
  );
<repeatable> = {$1} If(TimeContext.Restart("select", 0), "", "");
<repeatable> <n> = {$1_$2} If(TimeContext.Restart("select", 0), "", "");
chop =
  If(TimeContext.Restart("system", 0),
     SendSystemKeys({enter}),
     {enter})
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
chop <n> =
  {enter_$1}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
choppy = {end}{enter} If(TimeContext.Restart("select", 0), "", "");
choppy <n> = {end}{enter_$1} If(TimeContext.Restart("select", 0), "", "");

dodge =
  {esc}
  If(TimeContext.Restart("select", 0), {right}, "")
  If(TimeContext.Restart("controlselect", 0), "", "");

# wrappers
angel = "<>"{left};
inset = "()"{left};
bracken = "[]"{left};
curly = "{}"{left};
stringy = '""'{left};
singly = "''"{left};

# multiline wrappers
bay inset = "()"{left}{enter}{up}{end};
bay bracken = "[]"{left}{enter}{up}{end};
bay curly = "{}"{left}{enter}{up}{end};

# punctuation
adjourn = ";";
thunder = "_";
bang = "!";
pipe = "|";
dot = ".";
backslash = "\";
slash = "/";
# spaced punctuation
<spaced> :=
  ( dash = "-"
  | dasher = "-="
  | plus = "+"
  | plusser = "+="
  | divide = "/"
  | divider = "/="
  | star = "*"
  | starker = "*="
  | modulus = "%"
  | modulusser = "%="
  | banger = "!="
  | twin = "="
  | twinner = "=="
  | Lester = "<"
  | lesstwin = "<="
  | greater = ">"
  | graytwin = ">="
  | coaltwin = ":="
  | legend = "&&"
  | ledger = "||"
  | compass = "->"
  );
<spaced> = " $1 ";
bay <spaced> = $1;
comma = ", ";
bay comma = ",";

# scrolling
# to make this work, I had to add the following code at line 136 of
# /NatLink/NatLink/MacroSystem/core/ExtendedSendDragonKeys.py:
# if base in Wheel_name:
#     clicks_sign, horizontal = Wheel_name[base]
#     base_event = mouse_wheel_event(horizontal, hold_count * clicks_sign)
#     return modifiers_down + [base_event] + modifiers_up
pull = Keys.SendInput({wheeldown_1});
pull <n> = Keys.SendInput({wheeldown_$1});
ripple = Keys.SendInput({wheelup_1});
ripple <n> = Keys.SendInput({wheelup_$1});

# common shortcuts
revoke = {ctrl+z} If(TimeContext.Restart("select", 0), "", "");
grab all =
  {ctrl+a}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
banish = {ctrl+w};
bottle =
  {ctrl+c}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
bottle <n> =
  {ctrl+left_$1}{shift+ctrl+right_$1}{ctrl+c}
  If(TimeContext.Restart("select", 0), "", "");
snag =
  {ctrl+x}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
pour = {ctrl+v} If(TimeContext.Restart("select", 0), "", "");
xerox = {up}{end}{shift+down}{shift+end}{ctrl+c}{right}{ctrl+v};
stow = {ctrl+s};
forage = {ctrl+f} If(TimeContext.Restart("select", 0), "", "");

flip = SendSystemKeys({ctrl+alt+tab}) TimeContext.Start("system", 1, "noop()");
flip <n> = SendSystemKeys({ctrl+alt+tab_$1}) TimeContext.Start("system", 1, "noop()");
window left = SendSystemKeys({win+left});
window right = SendSystemKeys({win+right});

volley = Keys.SendInput({VolumeUp}{VolumeDown}) TimeContext.Start("volume", 3, "noop()");
mute = Keys.SendInput({VolumeMute});

time context ping = TimeContext.Ping();
tug <_anything> =
  MenuPick($1)
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
tug it =
  Keys.SendInput({Apps})
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");

# variables
camel <_anything> = EvalTemplate("%s[0].lower() + ''.join(%s.title().split())[1:]", $1, $1);
llama <_anything> = EvalTemplate("''.join(%s.title().split())", $1);
locus <_anything> = EvalTemplate("%s.lower()", $1);
fuse <_anything> = EvalTemplate("''.join(%s.lower().split())", $1);
snake <_anything> = EvalTemplate("'_'.join(%s.lower().split())", $1);
scream <_anything> = EvalTemplate("'_'.join(%s.upper().split())", $1);
kebab <_anything> = EvalTemplate("'-'.join(%s.lower().split())", $1);
