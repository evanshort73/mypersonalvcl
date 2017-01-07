# Global voice commands

# numbers
<d> := 0..9;
pay <d> = $1;
<n> := 0..50;

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
pay <a> = {shift+$1};
pay lock = TimeContext.Start("capslock", 40, "noop()");
pay unlock = If(TimeContext.Restart("capslock", 0), "", "");

grab =
  TimeContext.Start("select", 40, "noop()")
  If(TimeContext.Restart("controlselect", 0), "", "");
jetsam =
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");

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

rightEdge() := {shift+left}{right}; # go to right side of backward selection
leftEdge() := {shift+left}{left}{right}; # go to left side of backward selection
wordEnd() := {ctrl+left}{ctrl+right}; # go to right side of word under cursor
prevWordEnd() := {ctrl+right}{ctrl+left_2}{ctrl+right}; # if we're between words, stay there
skipWords(n) := {ctrl+right_ $n}; # move n words forwards
selectWords(n) := {shift+ctrl+left_ $n}; # select n words backwards
selectLine() := {shift+home}{shift+home}{shift+left}; # select previous newline without pressing up
selectLines(n) := {shift+up_ Eval("$n - 1")}{shift+end}{shift+home}{shift+home}{shift+left};
isNotSelecting() := EvalTemplate('%s == "False" and %s == "False"', TimeContext.Restart("select"), TimeContext.Restart("controlselect"));

# inside selecting arrows
nabby =
  If(isNotSelecting(),
     rightEdge() wordEnd() selectWords(1) {ctrl+c});
lappy =
  If(isNotSelecting(),
     rightEdge() wordEnd() selectWords(1));
taree =
  If(isNotSelecting(),
     leftEdge() skipWords(1) selectWords(1));
wiki =
  If(isNotSelecting(),
     rightEdge() {end} selectLine());
berry =
  If(isNotSelecting(),
     {left}{right} {end} selectLine());

# repeat inside selecting arrows
nabby <n> =
  If(isNotSelecting(),
     rightEdge() wordEnd() selectWords($1) {ctrl+c});
lappy <n> =
  If(isNotSelecting(),
     rightEdge() wordEnd() selectWords($1));
taree <n> =
  If(isNotSelecting(),
     leftEdge() skipWords($1) selectWords($1));
wiki <n> =
  If(isNotSelecting(),
     rightEdge() {end} selectLines($1));
berry <n> =
  If(isNotSelecting(),
     {left}{right} {down_ Eval("$1 - 1")} {end} selectLines($1));

# outside selecting arrows
nabsy =
  If(isNotSelecting(),
     leftEdge() prevWordEnd() selectWords(1) {ctrl+c});
lapsy =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        {shift+ctrl+left},
        leftEdge() prevWordEnd() selectWords(1)));
tarzy =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        {shift+ctrl+right},
        rightEdge() wordEnd() skipWords(1) selectWords(1)));
wicksy =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        {shift+end} selectLine(),
        {left}{right}{up} {end} selectLine()));
bearsy =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        {shift+right}{shift+end},
        rightEdge() {down} {end} selectLine()));

# repeat outside selecting arrows
nabsy <n> =
  If(isNotSelecting(),
     leftEdge() prevWordEnd() selectWords($1) {ctrl+c});
lapsy <n> =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        {shift+ctrl+left_$1},
        leftEdge() prevWordEnd() selectWords($1)));
tarzy <n> =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        {shift+ctrl+right_$1},
        rightEdge() wordEnd() skipWords($1) selectWords($1)));
wicksy <n> =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        selectLines($1),
        {left}{right}{up} {end} selectLines($1)));
bearsy <n> =
  If(TimeContext.Restart("controlselect"),
     "",
     If(TimeContext.Restart("select"),
        {shift+right} {shift+down_ Eval("$1 - 1")} {shift+end},
        rightEdge() {down_$1} {end} selectLines($1)));

# long-range arrows
pay lap = If(TimeContext.Restart("select"), {shift+home}, {home});
pay tar = If(TimeContext.Restart("select"), {shift+end}, {end});
pay wick = If(TimeContext.Restart("select"), {shift+pgup}, {pgup});
pay bear = If(TimeContext.Restart("select"), {shift+pgdn}, {pgdn});
pay wick <n> = If(TimeContext.Restart("select"), {shift+pgup_$1}, {pgup_$1});
pay bear <n> = If(TimeContext.Restart("select"), {shift+pgdn_$1}, {pgdn_$1});

# repeatable keys
<repeatable> :=
  ( levy = tab
  | lever = shift+tab
  | burn = del
  | wipe = backspace
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
pay chop = rightEdge() {end}{enter} If(TimeContext.Restart("select", 0), "", "");
pay chop <n> = rightEdge() {end}{enter_$1} If(TimeContext.Restart("select", 0), "", "");

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
pay inset = "()"{left}{enter}{up}{end};
pay bracken = "[]"{left}{enter}{up}{end};
pay curly = "{}"{left}{enter}{up}{end};

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
pay <spaced> = $1;
comma = ", ";
pay comma = ",";

# scrolling
# to make this work, I had to add the following code at line 136 of
# /NatLink/NatLink/MacroSystem/core/ExtendedSendDragonKeys.py:
# if base in Wheel_name:
#     clicks_sign, horizontal = Wheel_name[base]
#     base_event = mouse_wheel_event(horizontal, hold_count * clicks_sign)
#     return modifiers_down + [base_event] + modifiers_up
pull = Keys.SendInput({wheeldown_1});
pull <d> = Keys.SendInput({wheeldown_$1});
ripple = Keys.SendInput({wheelup_1});
ripple <d> = Keys.SendInput({wheelup_$1});

# common shortcuts
revoke = {ctrl+z} If(TimeContext.Restart("select", 0), "", "");
grab all =
  {ctrl+a}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
banish = {ctrl+w};
nab =
  {ctrl+c}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
nab all =
  {ctrl+a}{ctrl+c}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
spill = {ctrl+v} If(TimeContext.Restart("select", 0), "", "");
spill <d> = {ctrl+v_$1} If(TimeContext.Restart("select", 0), "", "");
pay spill = rightEdge() {end}{ctrl+v} If(TimeContext.Restart("select", 0), "", "");
pay spill <d> = rightEdge() {end}{ctrl+v_$1} If(TimeContext.Restart("select", 0), "", "");
stow = {ctrl+s};
forage = {ctrl+f} If(TimeContext.Restart("select", 0), "", "");

flip = SendSystemKeys({ctrl+alt+tab}) TimeContext.Start("system", 1, "noop()");
flip <d> = SendSystemKeys({ctrl+alt+tab_$1}) TimeContext.Start("system", 1, "noop()");
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

fuse it = leftEdge() {ctrl+left}{backspace}{ctrl+right};
snake it = leftEdge() {ctrl+left}{shift+left} "_" {ctrl+right};
