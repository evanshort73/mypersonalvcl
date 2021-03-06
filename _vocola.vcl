# Global voice commands

# numbers
<d> := 0..9;
fry <d> = $1;
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
  | lamb = l
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
fry <a> = {shift+$1};
scream = TimeContext.Start("capslock", 40);

selecting() := TimeContext.Restart("select");
collecting() := TimeContext.Restart("controlselect");
stopSelecting() := TimeContext.Start("select", 0);
stopCollecting() := TimeContext.Start("controlselect", 0);
stopCaps() := TimeContext.Start("capslock", 0);
notCollecting() := EvalTemplate('%s == "False"', collecting());
neitherSelecting() :=
  EvalTemplate('%s == "False" and %s == "False"', selecting(), collecting());

grab = TimeContext.Start("select", 40) stopCollecting();
jetsam = stopSelecting() stopCollecting() stopCaps();

# arrows
lap =
  If(selecting(), {shift+left},
     If(collecting(), {ctrl+left},
        {left}));
tar =
  If(selecting(), {shift+right},
     If(collecting(), {ctrl+right},
        {right}));
wick =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeUp_5}),
     If(selecting(), {shift+up},
        If(collecting(), {ctrl+up},
           {up})));
bear =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeDown_5}),
     If(selecting(), {shift+down},
        If(collecting(), {ctrl+down},
           {down})));

# repeat arrows
lap <n> =
  If(selecting(), {shift+left_$1},
     If(collecting(), {ctrl+left_$1},
        {left_$1}));
tar <n> =
  If(selecting(),
     {shift+right_$1},
     If(collecting(),
        {ctrl+right_$1},
        {right_$1}));
wick <n> =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeUp_ Eval("$1 * 5")}),
     If(selecting(), {shift+up_$1},
        If(collecting(), {ctrl+up_$1},
           {up_$1})));
bear <n> =
  If(TimeContext.Restart("volume"),
     Keys.SendInput({VolumeDown_ Eval("$1 * 5")}),
     If(selecting(), {shift+down_$1},
        If(collecting(), {ctrl+down_$1},
           {down_$1})));

rightEdge() := {shift+left}{right}; # go to right side of backward selection
leftEdge() := {shift+left}{left}{right}; # go to left side of backward selection
wordEnd() := {ctrl+left}{ctrl+right}; # go to right side of word under cursor
prevWordEnd() := {ctrl+right}{ctrl+left_2}{ctrl+right}; # if we're between words, stay there
skipWords(n) := {ctrl+right_ $n}; # move n words forwards
selectWords(n) := {shift+ctrl+left_ $n}; # select n words backwards
selectLine() := {shift+home}{shift+home}{shift+left}; # select previous newline without pressing up
selectLines(n) := {shift+up_ Eval("$n - 1")}{shift+end}{shift+home}{shift+home}{shift+left};

# inside selecting arrows
nabby =
  If(neitherSelecting(),
     rightEdge() wordEnd() selectWords(1) {ctrl+c});
lappy =
  If(neitherSelecting(),
     rightEdge() wordEnd() selectWords(1));
taree =
  If(neitherSelecting(),
     leftEdge() skipWords(1) selectWords(1));
stacky =
  If(neitherSelecting(),
     rightEdge() {end} selectLine() {ctrl+c});
wiki =
  If(neitherSelecting(),
     rightEdge() {end} selectLine());
berry =
  If(neitherSelecting(),
     {left}{right} {end} selectLine());

# repeat inside selecting arrows
nabby <n> =
  If(neitherSelecting(),
     rightEdge() wordEnd() selectWords($1) {ctrl+c});
lappy <n> =
  If(neitherSelecting(),
     rightEdge() wordEnd() selectWords($1));
taree <n> =
  If(neitherSelecting(),
     leftEdge() skipWords($1) selectWords($1));
stacky <n> =
  If(neitherSelecting(),
     rightEdge() {end} selectLines($1) {ctrl+c});
wiki <n> =
  If(neitherSelecting(),
     rightEdge() {end} selectLines($1));
berry <n> =
  If(neitherSelecting(),
     {left}{right} {down_ Eval("$1 - 1")} {end} selectLines($1));

# outside selecting arrows
nabsy =
  If(neitherSelecting(),
     leftEdge() prevWordEnd() selectWords(1) {ctrl+c});
lapsy =
  If(notCollecting(),
     If(selecting(), {shift+ctrl+left},
        leftEdge() prevWordEnd() selectWords(1)));
tarzy =
  If(notCollecting(),
     If(selecting(), {shift+ctrl+right},
        rightEdge() wordEnd() skipWords(1) selectWords(1)));
stacksy =
  If(neitherSelecting(),
     {left}{right}{up} {end} selectLine() {ctrl+c});
wicksy =
  If(notCollecting(),
     If(selecting(), {shift+end} selectLine(),
        {left}{right}{up} {end} selectLine()));
bearsy =
  If(notCollecting(),
     If(selecting(), {shift+right}{shift+end},
        rightEdge() {down} {end} selectLine()));

# repeat outside selecting arrows
nabsy <n> =
  If(neitherSelecting(),
     leftEdge() prevWordEnd() selectWords($1) {ctrl+c});
lapsy <n> =
  If(notCollecting(),
     If(selecting(), {shift+ctrl+left_$1},
        leftEdge() prevWordEnd() selectWords($1)));
tarzy <n> =
  If(notCollecting(),
     If(selecting(), {shift+ctrl+right_$1},
        rightEdge() wordEnd() skipWords($1) selectWords($1)));
stacksy <n> =
  If(neitherSelecting(),
     {left}{right}{up} {end} selectLines($1) {ctrl+c});
wicksy <n> =
  If(notCollecting(),
     If(selecting(), selectLines($1),
        {left}{right}{up} {end} selectLines($1)));
bearsy <n> =
  If(notCollecting(),
     If(selecting(), {shift+right} {shift+down_ Eval("$1 - 1")} {shift+end},
        rightEdge() {down_$1} {end} selectLines($1)));

# long-range arrows
ridgy = If(selecting(), {shift+home}, {home});
ridge = If(selecting(), {shift+end}, {end});
ripple = If(selecting(), {shift+pgup}, {pgup});
pull = If(selecting(), {shift+pgdn}, {pgdn});
ripple <n> = If(selecting(), {shift+pgup_$1}, {pgup_$1});
pull <n> = If(selecting(), {shift+pgdn_$1}, {pgdn_$1});

# repeatable keys
<repeatable> :=
  ( spin = tab
  | spinny = shift+tab
  | burn = del
  | swipe = backspace
  | sky = space
  );
<repeatable> = {$1} stopSelecting();
<repeatable> <n> = {$1_$2} stopSelecting();
sky = {space} stopSelecting() stopCaps();
sky <n> = {space_$1} stopSelecting() stopCaps();
chop = {enter} stopSelecting() stopCollecting();
chop <n> = {enter_$1} stopSelecting() stopCollecting();
fry chop = rightEdge() {end}{enter} stopSelecting();
fry chop <n> = rightEdge() {end}{enter_$1} stopSelecting();

dodge =
  {esc}
  If(TimeContext.Restart("select", 0), {right})
  stopCollecting();

# wrappers
angel = "<>"{left};
inset = "()"{left};
bracken = "[]"{left};
curly = "{}"{left};
stringy = '""'{left};
singly = "''"{left};

# multiline wrappers
fry inset = "()"{left}{enter};
fry bracken = "[]"{left}{enter};
fry curly = "{}"{left}{enter};

# punctuation
adjourn = ";";
thunder = "_" stopCaps();
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
fry <spaced> = $1;
sever = ", ";
fry sever = ",";

# scrolling
# to make this work, I had to add the following code at line 136 of
# /NatLink/NatLink/MacroSystem/core/ExtendedSendDragonKeys.py:
# if base in Wheel_name:
#     clicks_sign, horizontal = Wheel_name[base]
#     base_event = mouse_wheel_event(horizontal, hold_count * clicks_sign)
#     return modifiers_down + [base_event] + modifiers_up
crawl = Keys.SendInput({wheeldown_1});
crawl <d> = Keys.SendInput({wheeldown_$1});
crawly = Keys.SendInput({wheelup_1});
crawly <d> = Keys.SendInput({wheelup_$1});

# common shortcuts
verse = {ctrl+z} stopSelecting();
vercy = {ctrl+y} stopSelecting();
grab all = {ctrl+a} stopSelecting() stopCollecting();
banish = {ctrl+w};
nab = {ctrl+c} stopSelecting() stopCollecting();
nab all = {ctrl+a}{ctrl+c} stopSelecting() stopCollecting();
spill = {ctrl+v} stopSelecting();
spill <d> = {ctrl+v_$1} stopSelecting();
fry spill = rightEdge() {end}{ctrl+v} stopSelecting();
fry spill <d> = rightEdge() {end}{ctrl+v_$1} stopSelecting();
stow = {ctrl+s};
forage = {ctrl+f} stopSelecting();
ridge <_anything> =
  If(AnythingNumber.Validate($1),
     {ctrl+g} AnythingNumber.Convert($1) {enter} {end});
ridgy <_anything> =
  If(AnythingNumber.Validate($1),
     {ctrl+g} AnythingNumber.Convert($1) {enter} {end} {home});

# for Ditto Clipboard Manager, http://ditto-cp.sourceforge.net/
spilly = SendSystemKeys({ctrl+`}) stopSelecting();
spilly <d> = SendSystemKeys({ctrl+`}$1) stopSelecting();
fry spilly = rightEdge() {end} SendSystemKeys({ctrl+`}) stopSelecting();
fry spilly <d> = rightEdge() {end} SendSystemKeys({ctrl+`}$1) stopSelecting();

# http://www.ntwind.com/software/vistaswitcher.html
flip = Keys.SendInput({win+f12}) WaitForWindow("VistaSwitcher", "VistaSwitcher_SwitcherWnd");
<d3> := 3..9;
flip 1 = ;
flip 2 = Keys.SendInput({alt+tab});
flip <d3> = Keys.SendInput({win+f12}) WaitForWindow("VistaSwitcher", "VistaSwitcher_SwitcherWnd") $1 {enter};
window left = SendSystemKeys({win+left});
window right = SendSystemKeys({win+right});

volley = Keys.SendInput({VolumeUp}{VolumeDown}) TimeContext.Start("volume", 3);
mute = Keys.SendInput({VolumeMute});

tug <_anything> = MenuPick($1) stopSelecting() stopCollecting();
tug it = Keys.SendInput({Apps}) stopSelecting() stopCollecting();
dust = AppBringUp("/Users/Evan/Documents/GitHub/mousejump/mousejump.exe") WaitForWindow("MouseJump", "mousejump");

# variables
camel <_anything> = EvalTemplate("%s[0].lower() + %s.title()[1:]", $1, $1);
Cappy <_anything> = EvalTemplate("%s.title()", $1);
shy <_anything> = EvalTemplate("%s.lower()", $1);
scream <_anything> = EvalTemplate("%s.upper()", $1);

fuse =
  leftEdge()
  {ctrl+left}{backspace}
  {ctrl+right}
  stopCaps();
fuse <d> =
  leftEdge()
  Repeat($1, {ctrl+left}{backspace})
  {ctrl+right}
  stopCaps();
snake =
  leftEdge()
  {ctrl+left}{shift+left} "_"
  {ctrl+right}
  stopCaps();
snake <d> =
  leftEdge()
  Repeat(Eval($1 - 1), {ctrl+left}{shift+left} "_" {left})
  {ctrl+left}{shift+left} "_"
  {ctrl+right}
  stopCaps();
puff =
  leftEdge()
  {ctrl+left}{space}
  {ctrl+right}
  stopCaps();
puff <d> =
  leftEdge()
  Repeat($1, {ctrl+left}{space})
  {ctrl+right_$1}
  stopCaps();
coalesce = {end}{home}{shift+up}{shift+end}{space};
coalesce <d> = Repeat($1, {end}{home}{shift+up}{shift+end}{space});

wifi settings = AppBringUp("/Users/Evan/Documents/GitHub/mypersonalvcl/wifisettings.lnk");
