G91                                 ; relative positioning
G1 H2 Z10 F6000                     ; lift Z relative to current position
G1 H1 Y355 F6000                    ; move quickly to Y axis endstop and stop there (first pass)
G1 Y-5 F6000                        ; go back a few mm
G1 H1 Y355 F360                     ; move slowly to Y axis endstop once more (second pass)
G1 Y-5 F6000                        ; go back a few mm
G1 H2 Z-10 F6000                    ; lower Z again
G90                                 ; absolute positioning