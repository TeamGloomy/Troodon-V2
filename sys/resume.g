G1 R1 X0 Y0 Z5 F6000                ; go to 5mm above position of the last print move
G1 R1 X0 Y0 Z0                      ; go back to the last print move
M83                                 ; relative extruder moves
G1 E1.95 F3600                      ; extrude 1.95mm of filament