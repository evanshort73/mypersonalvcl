# Voice commands for explorer

rename = {f2};
venture = {f4};
cut =
  {ctrl+x}
  TimeContext.Start("select", 0)
  TimeContext.Start("controlselect", 0);
control grab =
  TimeContext.Start("controlselect", 40)
  TimeContext.Start("select", 0);
range =
  If(TimeContext.Restart("controlselect", 0),
     {ctrl+shift+space});
