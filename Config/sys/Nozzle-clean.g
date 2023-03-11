var thisMacroHeatOn = false

if tools[0].active[0] < {global.nozzleProbeTemperature}         ; check if the heater is powered and up to temp
    M568 P0 S{global.nozzleProbeTemperature} A2                 ; if cold set the nozzle temperature to 175 degrees
    M116 P0                                                     ; wait for the nozzle to reach temperature
    set var.thisMacroHeatOn = true                              ; set variable to show this macro set the temp
G90                                                             ; make sure the printer is set to absolute
G1 X270 Y352 F6000                                              ; move into position
G1 Z0.5 F3000                                                   ; lower z
G1 X320 F10000                                                  ; clean the nozzle
G1 X270 F10000                                                  ; clean the nozzle
G1 X320 F10000                                                  ; clean the nozzle
G1 X270 F10000                                                  ; clean the nozzle
G1 X320 F10000                                                  ; clean the nozzle
G1 X270 F10000                                                  ; clean the nozzle
G1 Z10 F6000                                                    ; lift the nozzle
if var.thisMacroHeatOn = true                                   ; check if the heater temperature was set by this macro
    M568 P0 S0 A0                                               ; turn the hotend off