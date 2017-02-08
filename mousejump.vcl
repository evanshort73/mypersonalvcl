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
