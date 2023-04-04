# Cura Start and End code

This is the start and end gcode to be used in conjunction with Cura

## Start Code

```
M104 S0
M190 S0
M98 P"start_print.g" A{material_bed_temperature_layer_0} B"{material_type}" C{material_print_temperature_layer_0} D{machine_nozzle_size}
```

# End Code

```
M0
```