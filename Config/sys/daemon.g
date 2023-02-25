;#################### Electronics Bay Fan ###########################
if move.axes[0].homed || move.axes[1].homed || move.axes[1].homed         ; check whether X, Y or Z drivers are active
  M106 P3 S255                                                            ; if they are, turn on the electronics bay fan
else
  M106 P3 S0                                                              ; if not, turn off the electronics bay fan