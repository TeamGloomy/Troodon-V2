G91                                         ; relative positioning
G1 H2 Z10 F6000                             ; lift Z relative to current position
if sensors.endstops[0].triggered = true     ; if we're hard against the endstop we need to move away
	M564 H0 S0
	G1 X-20 F1200
	M564 H1 S1
	M400
	if sensors.endstops[0].triggered = true
		abort "X Endstop appears to be faulty.  Still in triggered state."
G1 H1 X355 F6000                            ; move quickly to X axis endstop and stop there (first pass)
if result != 0
	abort "Print cancelled due error during fast homing"
G1 X-5 F6000                                ; go back a few mm
G1 H1 X355 F360                             ; move slowly to X axis endstop once more (second pass)
if result != 0
	abort "Print cancelled due to error during slow homing"
G1 X-5 F6000                                ; go back a few mm
G1 H2 Z-10 F6000                            ; lower Z again
G90                                         ; absolute positioning