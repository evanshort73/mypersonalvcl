# Voice commands for explorer

rename = {f2};
venture = {f4};
cut =
  {ctrl+x}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
control grab =
  TimeContext.Start("controlselect", 40, "noop()")
  If(TimeContext.Restart("select", 0), "", "");
range =
  If(TimeContext.Restart("controlselect", 0),
     {ctrl+shift+space},
     {shift+space});
