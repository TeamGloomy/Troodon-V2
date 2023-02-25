var ProbeSpeedHigh = sensors.probes[1].speeds[0] ; save currently configured speed for fast probe
var ProbeSpeedLow = sensors.probes[1].speeds[1] ; save currently configured speed for slow probe

M558 K1 F60 ; reduce probe speed to 60mm/min for accuracy - adjust F parameter as required

;define some variables to store readings

var NumTests=10 ; modify this value to define number of tests

; Do not change below this line
var RunningTotal=0
var Average=0
var Lowest=0
var Highest=0

; If the printer hasn't been homed, home it
if !move.axes[0].homed || !move.axes[1].homed || !move.axes[2].homed
  G28
else
	G1 X{(move.axes[0].min + move.axes[0].max)/2} Y{(move.axes[1].min + move.axes[1].max)/2} F3600 ; move nozzle to centre of bed
	G1 Z{sensors.probes[1].diveHeight} F360 ; if axes homed move to dive height

M561 ; clear any bed transform

M290 R0 S0 ; clear babystepping

M564 S0 H0 ; Allow movement beyond limits

;ensure you have room for the probe
if move.axes[2].machinePosition < sensors.probes[1].diveHeight
	G1 Z{sensors.probes[1].diveHeight}

M568 P0 S175 A2             							; Set the nozzle temperature to 175 degrees
M116 P0                     							; Wait for the nozzle to reach temperature

; Jog head to position
M291 P"Jog nozzle to touch bed" R"Set nozzle to zero" S3 Z1

G92 Z0 ; set Z position to zero
M291 P"Press OK to begin" R"Ready?" S3;

; Move probe over top of same point that nozzle was when zero was set
G1 Z{sensors.probes[1].diveHeight}; lift head
G1 X235 Y355.6 F1800

echo "Current probe offset = " ^ sensors.probes[1].triggerHeight ^ "mm"

; carry out 10 probes (or what is set in NumTests variable)

while iterations < var.NumTests
	G1 Z{sensors.probes[1].diveHeight} ; move to dive height
	G30 K1 S-1
	M118 P2 S{"Test # " ^ (iterations+1) ^ " Triggered @ " ^ move.axes[2].machinePosition ^ "mm"} ; send trigger height to Paneldue console
	M118 P3 S{"Test # " ^ (iterations+1) ^ " Triggered @ " ^ move.axes[2].machinePosition ^ "mm"} ; send trigger height to DWC console

	if iterations == 0
		set var.Lowest={move.axes[2].machinePosition} ; set the new lowest reading to first probe height
		set var.Highest={move.axes[2].machinePosition} ; set the new highest reading to first probe height

	if move.axes[2].machinePosition < var.Lowest
		set var.Lowest={move.axes[2].machinePosition} ; set the new lowest reading
		;M118 P3 S{"new low reading = " ^ move.axes[2].machinePosition} ; send trigger height to DWC console
		G4 S0.3
	if move.axes[2].machinePosition > var.Highest
		set var.Highest={move.axes[2].machinePosition} ; set the new highest reading

		;M118 P3 S{"new high reading = " ^ move.axes[2].machinePosition} ; send trigger height to DWC console
		G4 S0.3
	set var.RunningTotal={var.RunningTotal + move.axes[2].machinePosition} ; set new running total
	;M118 P3 S{"running total = " ^ var.RunningTotal} ; send running total to DWC console
	G4 S0.5
set var.Average = {(var.RunningTotal - var.Highest - var.Lowest) / (var.NumTests - 2)} 	; calculate the average after discarding th ehigh & low reading

;M118 P3 S{"running total = " ^ var.RunningTotal} ; send running total to DWC console
;M118 P3 S{"low reading = " ^ var.Lowest} ; send low reading to DWC console
;M118 P3 S{"high reading = " ^ var.Highest} ; send high reading to DWC console
M118 P2 S{"Average excluding high and low reading = " ^ var.Average} ; send average to PanelDue console
M118 P3 S{"Average excluding high and low reading = " ^ var.Average} ; send average to DWC console

;suggest new G31 values
echo "suggested edit for G31 K1 in config.g if not saved to config-overide.g"
echo "change G1 Z parameter from Z" ^ sensors.probes[1].triggerHeight 
echo "to Z" ^ var.Average

G31 K1 P500 Z{var.Average} ; set Z probe offset to the average reading
M564 S1 H1 ; Reset limits
M558 K1 F{var.ProbeSpeedHigh}:{var.ProbeSpeedLow} ; reset probe speed to original
G1 Z{sensors.probes[1].diveHeight} F360 ; move head back to dive height

M291 P{"Trigger height set to : " ^ sensors.probes[1].triggerHeight  ^ " OK to save to config-overide.g, cancel to use until next restart"} R"Finished" S3
M500 P31 ; optionally save result to config-overide.g

M568 P0 S0 A0               							; Turn the hotend off