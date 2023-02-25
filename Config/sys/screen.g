M950 E0 C"LCD_D5" T2 L300:900:1250:250 Q2500000         ; configure the neopixel pin
M150 K0 X2 R0 U0 B0 S3 F0                               ; turn off the backlight
M950 P1 C"LCD_D4"                                       ; configure reset pin
M42 P1 S0                                               ; hardware reset of LCD
G4 P500                                                 ; wait 500ms
M42 P1 S1                                               ; turn display on
M918 P2 C30 F1000000 E-4                                ; setup display type
while iterations < 256                                  ; fade in backlight
    M150 X2 R255 U255 B255 P{iterations} S1 F0
    G4 P20
while iterations < 3                                    ; flash button 3 times
    M150 K0 R0 U255 B0 P255 S2 F1
    M150 K0 R255 U255 B255 P255 S1 F0
    G4 P250
    M150 K0 R0 U255 B0 P0 S2 F1
    M150 K0 R255 U255 B255 P255 S1 F0
    G4 P250
M150 K0 R255 U0 B0 P255 S2 F1                           ; display "ready" button state  
M150 K0 R255 U255 B255 P255 S1 F0