if !exists(global.slicerBedTemp)											; checks for the existence of global.slicerBedTemp
	global slicerBedTemp = 0												; if it doesn't exist, set the value to 0
if !exists(global.slicerBedTempOverride)									; checks for the existence of global.slicerBedTempOverride
	global slicerBedTempOverride = 0										; if it doesn't exist, set the value to 0
if !exists(global.slicerHotendTemp)										    ; checks for the existence of global.slicerHotendTemp
	global slicerHotendTemp = 0											    ; if it doesn't exist, set the value to 0
if !exists(global.slicerHotendTempOverride)								    ; checks for the existence of global.slicerHotendTempOverride
	global slicerHotendTempOverride = 0									    ; if it doesn't exist, set the value to 0
if !exists(global.soakTime)													; checks for the existence of global.soakTime
	global soakTime = 15				                        			; if it doesn't exist, set the value in seconds. Value is in minutes
if !exists(global.soakTimeOverride)											; checks for the existence of global.soakTimeOverride
	global soakTimeOverride = false											; if it doesn't exist, set the value to false
if !exists(global.chamberCheckOverride)										; checks for the existence of global.chamberCheckOverride
	global chamberCheckOverride = false										; if it doesn't exist, set the value to false
if !exists(global.overrideBedOff)											; checks for the existence of global.overrideBedOff
	global overrideBedOff = false											; if it doesn't exist, set the value to false
if !exists(global.overrideHotendOff)										; checks for the existence of global.overrideHotendOff
	global overrideHotendOff = false										; if it doesn't exist, set the value to false
if !exists(global.nozzleDiameterInstalled)									; checks for the existence of global.nozzleDiameterInstalled
	global nozzleDiameterInstalled = 0.4									; if it doesn't exist, set the value to 0.4mm, which is the default for the Troodon V2
if !exists(global.nozzleProbeTemperature)									; checks for the existence of global.nozzleProbeTemperature
	global nozzleProbeTemperature = 175										; if it doesn't exist, set the value to 175 degrees
if !exists(global.Cancelled)												; checks for the existence of global.Cancelled
	global Cancelled = false                                                ; if it doesn't exist, set the value to false
if !exists(global.useAutoZ)													; checks for the existence of global.useAutoZ
	global useAutoZ = false                                                 ; if it doesn't exist, set the value to false
if !exists(global.levelBed)													; checks for the existence of global.levelBed
	global levelBed = false                                                 ; if it doesn't exist, set the value to false