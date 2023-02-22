; bed.g take from the teamgloomy wiki
; version 1.0
if !move.axes[0].homed || !move.axes[1].homed	        ; If the printer hasn't been homed, home it
	G28 XY	; home y and x
G28 Z			                                        ; home z
M561							                        ; clear any bed transform
M671 S20
G30 P2 X345 Y330 Z-99999 ; probe near a leadscrew
G30 P3 X345 Y12 Z-99999 ; probe near a leadscrew
G30 P0 X9 Y12 Z-99999
G30 P1 X9 Y330 Z-99999 S4 ; probe near a leadscrew and calibrate 4 motors
echo "BTC: 1 - Difference was " ^ move.calibration.initial.deviation ^ "mm"
while move.calibration.initial.deviation >= 0.01		; perform additional tramming if previous deviation was over 0.01mm
  if iterations = 5
    abort "Too many auto tramming attempts"
  G30 P2 X345 Y330 Z-99999 ; probe near a leadscrew
  G30 P3 X345 Y12 Z-99999 ; probe near a leadscrew
  G30 P0 X9 Y12 Z-99999
  G30 P1 X9 Y330 Z-99999 S4 ; probe near a leadscrew and calibrate 4 motors
  echo "BTC: " ^ iterations + 2 ^ " - Difference was " ^ move.calibration.initial.deviation ^ "mm"
  continue
G28 Z							                        ; home z




