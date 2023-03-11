var thisMacroHeatOn = false											; initialise a local variable ready for use

if !move.axes[0].homed || !move.axes[1].homed	        			; If the printer hasn't been homed, home it
	G28 XY	                                            			; home y and x
G91                                                     			; relative positioning
G1 H2 Z10 F6000                                         			; lift Z relative to current position
G90                                                     			; absolute positioning
G1 X235 Y355.6 F10000                                   			; move above the autoZ probe
if tools[0].active[0] < 175                             			; check if the heater is powered and up to temp
    M568 P0 S{global.nozzleProbeTemperature} A2         			; if cold set the nozzle temperature to 175 degrees
    M116 P0                                             			; wait for the nozzle to reach temperature
    set var.thisMacroHeatOn = true                      			; set variable to show this macro set the temp
G30 K1 Z-99999                                          			; home Z by probing the autoZ
G1 Z4 F100                                              			; lift Z
if var.thisMacroHeatOn = true                           			; check if the heater temperature was set by this macro
    M568 P0 S0 A0                                       			; turn the hotend off
G1 X{(move.axes[0].min + move.axes[0].max)/2} Y{(move.axes[1].min + move.axes[1].max)/2} F3600    ; Move to the centre of the bed