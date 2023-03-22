
;#################### General preferences ###############
G90                                                     ; send absolute coordinates...
M83                                                     ; ...but relative extruder moves
M550 P"Troodon 2"                                       ; set printer name
M669 K1                                                 ; select CoreXY mode

;#################### Network ###########################
M552 S1                                                 ; enable network
M586 P0 S1                                              ; enable HTTP
M586 P1 S0                                              ; disable FTP
M586 P2 S0                                              ; disable Telnet

;#################### Axis Mapping ######################
; --- drive map ---
;    _______
;   | 3 | 6 |
;   | ----- |
;   | 4 | 5 |
;    -------
;     front
M584 X0 Y1 Z4:3:6:5 E2                                  ; set drive mapping

;#################### Drives ############################
M569 P0 S1                                              ; physical drive 0 goes forwards using default driver timings
M569 P1 S1                                              ; physical drive 1 goes forwards using default driver timings
M569 P2 S1                                              ; physical drive 2 goes forwards using default driver timings
M569 P3 S0                                              ; physical drive 3 goes forwards using default driver timings
M569 P4 S1                                              ; physical drive 4 goes forwards using default driver timings
M569 P5 S0                                              ; physical drive 5 goes forwards using default driver timings
M569 P6 S1                                              ; physical drive 6 goes forwards using default driver timings
M350 X16 Y16 Z16 E16 I1                                 ; configure microstepping with interpolation
M92 X80.00 Y80.00 Z400.00 E417.00                       ; set steps per mm
M566 X300 Y300 Z240 E300                                ; maximum instantaneous speed changes (mm/min) (jerk)
M203 X30000 Y30000 Z4000 E5000                          ; maximum speeds (mm/min)
M201 X2000 Y2000 Z650 E3200	                            ; accelerations
M906 X1600 Y1600 Z1600 E800 I30                         ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                                 ; Set idle timeout

;#################### Axis Limits #######################
M208 X0 Y0 Z0 S1                                        ; set axis minima
M208 X355 Y357 Z320 S0                                  ; set axis maxima
M671 X-50:-50:405:405 Y-75:355:355:-75 S20              ; set gantry pivot points

;#################### Endstops ##########################
M574 X2 S1 P"xstop"                                     ; configure switch-type (e.g. microswitch) endstop for low end on X via pin xstop
M574 Y2 S1 P"ystop"                                     ; configure switch-type (e.g. microswitch) endstop for low end on Y via pin ystop

;#################### Print Head Probe ##################
M558 K0 P5 C"probe" T12000 F300:120 H10 A10 S0.01       ; configure the probe on the print head
G31 K0 P500 X0 Y25 Z3                                   ; set Z probe X, Y and Z offsets
M557 X10:345 Y10:330 P10                                ; define mesh grid

;#################### Nozzle Probe ######################
M558 K1 P8 C"zstop" T18000 F180 H5 A10 S0.0025 R0       ; configure the probe used by autoz
G31 K1 P500 X0 Y0 Z3                                    ; set autoZ probe X, Y and Z offsets

;#################### Heaters ###########################
M308 S0 P"bedtemp" Y"thermistor" T100000 B3950          ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bed" T0 Q10                                   ; create bed heater output on bed and map it to sensor 0
M140 H0                                                 ; map heated bed to heater 0
M143 H0 S130                                            ; set temperature limit for heater 0 to 125C

M308 S1 P"e0temp" Y"pt1000"                             ; configure sensor 1 as thermistor on pin e0temp
M950 H1 C"e0heat" T1                                    ; create nozzle heater output on e0heat and map it to sensor 1
M307 H1 A517.3 C213.3 D11.1 V24 B0                      ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S460                                            ; set temperature limit for heater 1 to 460C

M308 S10 Y"mcu-temp" A"MCU"                           	; defines sensor 10 as MCU temperature sensor

;#################### Fans ##############################
M950 F0 C"fan1" Q500                                    ; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1 C"Part Cooling"                          ; set fan 0 value. Thermostatic control is turned ON
M950 F1 C"fan0" Q500                                    ; create fan 1 on pin out8 and set its frequency
M106 P1 S1 H1 T50 C"Hotend Fan"                         ; set fan 1 value. Thermostatic control is turned off
M950 F2 C"fan2" Q40                                     ; create fan 2 on pin out8 and set its frequency
M106 P2 S0 H-1 C"Chamber Fan"                           ; set fan 2 value. Thermostatic control is turned off
M950 F3 C"fan3" Q500                                    ; create fan 3 on pin fan0 and set its frequency
M106 P3 S0 H-1 C"Electronics Fan"                       ; set fan 3 value. Thermostatic control is turned ON
M950 F4 C"fan4" Q500                                    ; create fan 4 on pin out8 and set its frequency
M106 P4 S0 H-1 C"LED"                                   ; set fan 4 value. Thermostatic control is turned off

;#################### Tools #############################
M563 P0 D0 H1 F0                                        ; define tool 0
G10 P0 X0 Y0 Z0                                         ; set tool 0 axis offsets
G10 P0 R0 S0                                            ; set initial tool 0 active and standby temperatures to 0C

;#################### Filament Sensor ###################
M591 D0 P1 C"e0stop" S1                                 ; define the filament sensor for D0

;#################### Firmware Retraction ###############
M207 S0.5 F1800 Z0.2									; 0.5mm retraction, 0.2mm Z hop

;#################### Pressure Advance ##################
M572 D0 S0.045                                          ; define pressure advance for D0

;#################### 12864 Screen ######################
M98 P"screen.g"                                         ; run screen.g

;#################### Load Settings from Config-override 
M501                                                    ; load overrides from config-override.g

;#################### Globals ###########################
M98 P"globals.g"                                        ; initialize global variables

T0                                                      ; select tool 0