if !move.axes[0].homed || !move.axes[1].homed	        ; If the printer hasn't been homed, home it
  G28 XY	                                            ; home y and x
G91                                                     ; relative positioning
G1 H2 Z10 F6000                                         ; lift Z relative to current position
G90                                                     ; absolute positioning
G1 X{(move.axes[0].min + move.axes[0].max)/2 - sensors.probes[0].offsets[0]} Y{(move.axes[1].min + move.axes[1].max)/2 - sensors.probes[0].offsets[1]} F3600    ; Move to the centre of the bed taking the zprobe offsets into account
M558 K0 H10                                             ; Set the dive height for the probe to 10mm
M568 P0 S{global.nozzleProbeTemperature} A2         	; if cold set the nozzle temperature to 175 degrees
M116 P0                                             	; wait for the nozzle to reach temperature
G30                                                     ; probe the bed
if !exists(param.A)										; check if param.A doesn't exist
  M568 P0 S0 A0                                       	; turn the hotend off