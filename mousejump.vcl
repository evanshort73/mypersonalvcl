# Voice commands for mousejump

prependNumberIfInRange(number, command) :=
  If(
    Eval("$number >= 100 and $number < 1000"),
    $number $command);
prependIfInRange(anything, command) :=
  If(
    AnythingNumber.Validate($anything),
    prependNumberIfInRange(
      AnythingNumber.Convert($anything),
      $command));

chop <_anything> = prependIfInRange($1, {enter});
tug <_anything> = prependIfInRange($1, Keys.SendInput({Apps}));
spin <_anything> = prependIfInRange($1, {tab});
sky <_anything> = prependIfInRange($1, {space});
dodge <_anything> = prependIfInRange($1, {escape});

chop = {enter};
tug it = Keys.SendInput({Apps});
spin = {tab};
sky = {space};
dodge = {escape};

lap = {left};
tar = {right};
wick = {up};
bear = {down};

<n> := 0..50;
lap <n> = {left_$1};
tar <n> = {right_$1};
wick <n> = {up_$1};
bear <n> = {down_$1};
