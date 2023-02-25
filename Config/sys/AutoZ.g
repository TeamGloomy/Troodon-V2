if !move.axes[0].homed || !move.axes[1].homed	        ; If the printer hasn't been homed, home it
	G28 XY	                                            ; home y and x
G91                                                     ; relative positioning
G1 H2 Z10 F6000                                         ; lift Z relative to current position
G90                                                     ; absolute positioning
G1 X235 Y355.6 F10000                                   ; move above the autoZ probe
M568 P0 S175 A2             							; Set the nozzle temperature to 175 degrees
M116 P0                     							; Wait for the nozzle to reach temperature
G30 K1 Z-99999                                          ; home Z by probing the autoZ
M568 P0 S0 A0               							; Turn the hotend off
G1 Z4 F100                                              ; lift Z
G1 X{(move.axes[0].min + move.axes[0].max)/2} Y{(move.axes[1].min + move.axes[1].max)/2} F3600    ; Move to the centre of the bed