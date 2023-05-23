; This command will only create a mesh of the print area
; This will reduce the printing time considerably by only probing what is needed

var deviationFromOriginal = 20

var probeGridMinX = move.compensation.probeGrid.mins[0]
var probeGridMaxX = move.compensation.probeGrid.maxs[0]
var probeGridMinY = move.compensation.probeGrid.mins[1]
var probeGridMaxY = move.compensation.probeGrid.maxs[1]

var pamMinX = {var.probeGridMinX}	; Default the pamMinX value to the min x that is set for the mesh in M557. Originally coming from sys/printer_size_config.g
var pamMaxX = {var.probeGridMaxX} 	; Default the pamMaxX value to the min x that is set for the mesh in M557. Originally coming from sys/printer_size_config.g
var pamMinY = {var.probeGridMinY}	; Default the pamMinY value to the min x that is set for the mesh in M557. Originally coming from sys/printer_size_config.g
var pamMaxY = {var.probeGridMaxY}	; Default the pamMaxY value to the min x that is set for the mesh in M557. Originally coming from sys/printer_size_config.g
var meshSpacing = {move.compensation.probeGrid.spacings[0]}	; Grabbing the spacing of the current M557 settings
var minMeshPoints = 3				; The minimal amount of probing points for both X & Y.
var maxMeshPoints = 10				; The max amount of probing points for both X & Y

if exists(param.A)
	set var.pamMinX = {param.A}		; The min X position of the print job
	
if exists(param.B)
	set var.pamMaxX = {param.B}		; The max X position of the print job
	
if exists(param.C)	
	set var.pamMinY = {param.C}		; The min Y position of the print job
	
if exists(param.D)
	set var.pamMaxY = {param.D}		; The max Y position of the print job

if (var.probeGridMinX + var.deviationFromOriginal) >= var.pamMinX	; Check if the difference between the min X and the print job min X is smaller than the set deviation
	set var.pamMinX = {var.probeGridMinX}								; The difference is smaller than the set deviation so set minX to the minimal of the printer's X
	
if (var.probeGridMaxX - var.deviationFromOriginal) <= var.pamMaxX	; Check if the difference between the max X and the print job max X is smaller than the set devation
	set var.pamMaxX = {var.probeGridMaxX}								; The difference is smaller than the set devation so set maxX to the max of the printer's X
	
if (var.probeGridMinY + var.deviationFromOriginal) >= var.pamMinY	; Check if the difference between the min Y and the print job min Y is smaller than the set devation
	set var.pamMinY = {var.probeGridMinY}									; the difference is smaller than the set devation so set minY to the minimal of the printer's Y
	
if (var.probeGridMaxY - var.deviationFromOriginal) <= var.pamMaxY	; Check if the difference between the max X and the print job max X is smaller than the set devation
	set var.pamMaxY = {var.probeGridMaxY}									; The difference is smaller than the set devation so set maxY to the max of the printer's Y
	
var meshX = floor(min(var.maxMeshPoints - 1, (max(var.minMeshPoints - 1, (var.pamMaxX - var.pamMinX) / var.meshSpacing) + 1)))	; Get the number of probes for X taking minMeshPoints and maxMeshPoints into account
var meshY = floor(min(var.maxMeshPoints - 1, (max(var.minMeshPoints - 1, (var.pamMaxY - var.pamMinY) / var.meshSpacing) + 1)))	; Get the number of probes for Y taking minMeshPoints and maxMeshPoints into account

var consoleMessage = "Set probe grid to use X-min: " ^ var.pamMinX ^ "; X-max: " ^ var.pamMaxX ^ "; Y-min: " ^ var.pamMinY ^ "; Y-max: " ^ var.pamMaxY "; Probing points: " ^ var.meshX ^ ";" ^ var.meshY	; Set the console message
M118 P2 S{var.consoleMessage} ; send used probe grid to paneldue
M118 P3 S{var.consoleMessage} ; send average to DWC console

M557 X{var.pamMinX, var.pamMaxX} Y{var.pamMinY, var.pamMaxY} P{var.meshX, var.meshY}	; Set the probing mesh

G0 X{var.pamMinX + ((var.pamMaxX - var.pamMinX)/2) - sensors.probes[0].offsets[0]} Y{var.pamMinY + ((var.pamMaxY - var.pamMinY)/2) - sensors.probes[0].offsets[1]} 	; Move to the center of the print area
G30	; Set the z height for the center of the print area
G29	; Probe the print area

; Restore the probing mesh to the original settings
set var.meshX = floor((var.probeGridMaxX - var.probeGridMinX) / var.meshSpacing + 1)
set var.meshY = floor((var.probeGridMaxY - var.probeGridMinY) / var.meshSpacing + 1)
M557 X{var.probeGridMinX, var.probeGridMaxX} Y{var.probeGridMinY, var.probeGridMaxY} P{var.meshX, var.meshY}

