# Cura Start and End code

This is the start and end gcode to be used in conjunction with Cura

## Start Code

```
M104 S0
M190 S0
M98 P"start_print.g" A{material_bed_temperature_layer_0} B"{material_type}" C{material_print_temperature_layer_0} D{machine_nozzle_size} E%MINX% F%MAXX% H%MINY% J%MAXY%
```

# End Code

```
M0
```

To make PAM work with Cura you need to install a post processing plugin

1. in cura open menu ```Help -> Show configuration folder```
2. copy [MeshPrintSize.py](/MeshPrintSize.py) into the ```scripts``` folder
3. restart cura
4. in cura open menu ```Extensions -> Post processing -> Modify G-Code``` and select ```Mesh Print Size```