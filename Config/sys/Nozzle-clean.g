M568 P0 S175 A2                         ; set the nozzle temperature to 175 degrees
M116 P0                                 ; wait for the nozzle to reach temperature
G90                                     ; make sure the printer is set to absolute
G1 X270 Y356 F6000                      ; move into position
G1 Z0.5 F3000                           ; lower z
G1 X320 F10000                          ; clean the nozzle
G1 X270 F10000                          ; clean the nozzle
G1 X320 F10000                          ; clean the nozzle
G1 X270 F10000                          ; clean the nozzle
G1 X320 F10000                          ; clean the nozzle
G1 X270 F10000                          ; clean the nozzle
G1 Z10 F6000                            ; lift the nozzle
M568 P0 S0 A0                           ; turn the hotend off