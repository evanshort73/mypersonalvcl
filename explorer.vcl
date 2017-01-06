# Voice commands for explorer

rename = {f2};
venture = {f4};
cut =
  {ctrl+x}
  If(TimeContext.Restart("select", 0), "", "")
  If(TimeContext.Restart("controlselect", 0), "", "");
