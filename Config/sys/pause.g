M83                                 ; relative extruder moves
G1 E2 F3600                         ; retract 2mm of filament
G91                                 ; relative positioning
G1 Z5 F360                          ; lift Z by 5mm relative to the print
G90                                 ; absolute positioning
G1 X{(move.axes[0].min + move.axes[0].max)/2} Y{move.axes[1].min} F3600        ; move the toolhead to the front and centre of the machine