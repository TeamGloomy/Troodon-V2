; parameters
; A = maximum speed in mm/s
; B = maximum acceleration in mm/s2
; C = iterations
; D = Bound Size in mm
; E = smallPatternSize in mm
 
; Set up local variables
var speedXCurrent = move.axes[0].speed
var speedYCurrent = move.axes[1].speed
var accelerationXCurrent = move.axes[0].acceleration
var accelerationYCurrent = move.axes[1].acceleration
var speedX = 0
var speedY = 0
var accelerationX = 0
var accelerationY = 0
var macroIterations = 0
var bound = 0
var smallPatternSize = 0
var xPositionStart = 0
var yPositionStart = 0
var xPositionEnd = 0
var yPositionEnd = 0
var xEndstopHigh = sensors.endstops[0].highEnd
var yEndstopHigh = sensors.endstops[1].highEnd
var xPositionDifference = 0
var yPositionDifference = 0
var xMMPerFullStep = 0
var yMMPerFullStep = 0
 
if !exists(param.A)
	set var.speedX = move.axes[0].speed / 60
	set var.speedY = move.axes[1].speed / 60
else 
	set var.speedX = param.A
	set var.speedY = param.A
 
if !exists(param.B)
	set var.accelerationX = move.axes[0].acceleration
	set var.accelerationY = move.axes[1].acceleration
else
	set var.accelerationX = param.B
	set var.accelerationY = param.B
 
if !exists(param.C)
	set var.macroIterations = 5
else
	set var.macroIterations = param.C
 
if !exists(param.D)
	set var.bound = 20
else
	set var.bound = param.D
	
if !exists(param.E)
	set var.smallPatternSize = 20
else
	set var.smallPatternSize = param.E
 
; Large Pattern
var x_min = move.axes[0].min + var.bound
var x_max = move.axes[0].max - var.bound
var y_min = move.axes[1].min + var.bound
var y_max = move.axes[1].max - var.bound
 
; Small Pattern at Centre
var x_centre = ( move.axes[0].max - move.axes[0].min ) / 2
var y_centre = ( move.axes[1].max - move.axes[1].min ) / 2
 
; Set Small Pattern Box Around Centre Point
var x_centre_min = var.x_centre - (var.smallPatternSize/2)
var x_centre_max = var.x_centre + (var.smallPatternSize/2)
var y_centre_min = var.y_centre - (var.smallPatternSize/2)
var y_centre_max = var.y_centre + (var.smallPatternSize/2)
 
M118 P0 S"Starting Speed Test"
 
; Home and get position for comparison later
G28
G32
G90
if var.xEndstopHigh
	G0 X{move.axes[0].max - 1} F1800
else
	G0 X{move.axes[0].min + 1} F1800
if var.yEndstopHigh
	G0 Y{move.axes[1].max - 1} F1800
else
	G0 Y{move.axes[1].min + 1} F1800
M400
G4 S1
set var.xPositionStart = move.axes[0].machinePosition
set var.yPositionStart = move.axes[1].machinePosition
 
echo "Start X Position is " ^ var.xPositionStart
echo "Start Y Position is " ^ var.yPositionStart
 
; Set New Limits
; Speeds
M203 X{var.speedX*60} Y{var.speedY*60}
; Accelerations
M201 X{var.accelerationX} Y{var.accelerationY}
 
; Go to Start Position
G0 X{var.x_min} Y{var.y_min} Z{var.bound + 10} F{var.speedX*60}
 
; Movement
while iterations < var.macroIterations
 
	; Large Pattern
	; Diagonals
	G0 X{var.x_min} Y{var.y_min} F{var.speedX*60}
	G0 X{var.x_max} Y{var.y_max} F{var.speedX*60}
	G0 X{var.x_min} Y{var.y_min} F{var.speedX*60}
	G0 X{var.x_max} Y{var.y_min} F{var.speedX*60}
	G0 X{var.x_min} Y{var.y_max} F{var.speedX*60}
	G0 X{var.x_max} Y{var.y_min} F{var.speedX*60}
 
	; Box
	G0 X{var.x_min} Y{var.y_min} F{var.speedX*60}
	G0 X{var.x_min} Y{var.y_max} F{var.speedX*60}
	G0 X{var.x_max} Y{var.y_max} F{var.speedX*60}
	G0 X{var.x_max} Y{var.y_min} F{var.speedX*60}
 
	; Small Pattern
	; Diagonals
	G0 X{var.x_centre_min} Y{var.y_centre_min} F{var.speedX*60}
	G0 X{var.x_centre_max} Y{var.y_centre_max} F{var.speedX*60}
	G0 X{var.x_centre_min} Y{var.y_centre_min} F{var.speedX*60}
	G0 X{var.x_centre_max} Y{var.y_centre_min} F{var.speedX*60}
	G0 X{var.x_centre_min} Y{var.y_centre_max} F{var.speedX*60}
	G0 X{var.x_centre_max} Y{var.y_centre_min} F{var.speedX*60}
 
	; Box
	G0 X{var.x_centre_min} Y{var.y_centre_min} F{var.speedX*60}
	G0 X{var.x_centre_min} Y{var.y_centre_max} F{var.speedX*60}
	G0 X{var.x_centre_max} Y{var.y_centre_max} F{var.speedX*60}
	G0 X{var.x_centre_max} Y{var.y_centre_min} F{var.speedX*60}
 
; Restore Limits
; Speeds
M203 X{var.speedXCurrent} Y{var.speedYCurrent}
; Accelerations
M201 X{var.accelerationXCurrent} Y{var.accelerationYCurrent}
 
; Go back to 1mm from endstops and measure distance to endstop for Comparison
G90
if var.xEndstopHigh
	G0 X{move.axes[0].max - 1} F1800
	M400
	G4 S1
	G91
	G1 H4 X{move.axes[0].max} F60
	G90
	M400
	G4 S1
	set var.xPositionEnd = move.axes[0].machinePosition - 1
else
	G0 X{move.axes[0].min + 1} F1800
	M400
	G4 S1
	G91
	G1 H4 X{-move.axes[0].max} F60
	G90
	M400
	G4 S1
	set var.xPositionEnd = move.axes[0].machinePosition + 1
if var.yEndstopHigh
	G0 Y{move.axes[1].max - 1} F1800
	M400
	G4 S1
	G91
	G1 H4 Y{move.axes[1].max} F60
	M400
	G4 S1
	set var.yPositionEnd = move.axes[1].machinePosition - 1
else
	G0 Y{move.axes[1].min + 1} F1800
	M400
	G4 S1
	G91
	G1 H4 Y{-move.axes[1].max} F60
	M400
	G4 S1
	set var.yPositionEnd = move.axes[1].machinePosition + 1
 
echo "End X Position is " ^ var.xPositionEnd
echo "End Y Position is " ^ var.yPositionEnd
set var.xPositionDifference = abs(var.xPositionStart - var.xPositionEnd)
set var.yPositionDifference = abs(var.yPositionStart - var.yPositionEnd)
 
echo "X difference is " ^ var.xPositionDifference
echo "Y difference is " ^ var.yPositionDifference
 
set var.xMMPerFullStep = (1 / move.axes[0].stepsPerMm) + (1 / move.axes[0].stepsPerMm / move.axes[0].microstepping.value)
set var.yMMPerFullStep = (1 / move.axes[1].stepsPerMm) + (1 / move.axes[1].stepsPerMm / move.axes[1].microstepping.value)
 
if var.xPositionDifference >= var.xMMPerFullStep
	M118 P0 S"There has been some skipping detected on the X axis. Please lower your acceleration or speed and test again"
else
	M118 P0 S"There has been no skipping detected on the X axis"
 
if var.yPositionDifference >= var.yMMPerFullStep
	M118 P0 S"There has been some skipping detected on the Y axis. Please lower your acceleration or speed and test again"
else
	M118 P0 S"There has been no skipping detected on the Y axis"