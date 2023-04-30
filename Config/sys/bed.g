; bed.g taken from the teamgloomy wiki
if !move.axes[0].homed || !move.axes[1].homed	                                    ; If the printer hasn't been homed, home it
	G28 XY	                                                                        ; home y and x
G29 S2                                                                            ; turn off bed mesh levelling
M561                                                                              ; clear any bed transform
M290 R0 S0                                                                        ; clear babystepping
G28 Z			                                                                  ; home z
M558 K0 H10                                                                       ; set toolhead probe dive height to 10mm
G30 P0 X30 Y50 Z-99999                                                             ; probe front left
G30 P1 X30 Y320 Z-99999                                                            ; prove back left
G30 P2 X320 Y320 Z-99999                                                          ; probe back right
G30 P3 X320 Y50 Z-99999 S4                                                        ; probe front right and level
M558 K0 H3                                                                        ; set toolhead probe dive height to 3mm to speed up levelling
echo "BTC: 1 - Difference was " ^ move.calibration.initial.deviation ^ "mm"       ; echo deviation
while move.calibration.initial.deviation >= 0.01		                              ; perform additional tramming if previous deviation was over 0.01mm
  if iterations = 5                                                               ; check that not more than 5 levelling attempts have been made
    abort "Too many auto tramming attempts"                                       ; abort if = to 5
  G30 P0 X30 Y50 Z-99999                                                           ; probe front left
  G30 P1 X30 Y320 Z-99999                                                          ; prove back left
  G30 P2 X320 Y320 Z-99999                                                        ; probe back right
  G30 P3 X320 Y50 Z-99999 S4                                                      ; probe front right and level
  echo "BTC: " ^ iterations + 2 ^ " - Difference was " ^ move.calibration.initial.deviation ^ "mm"    ; echo deviation
  continue
G28 Z							                                                                ; home z again incase levelling has affected z height