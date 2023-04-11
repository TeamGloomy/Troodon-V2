# PrusaSlicer

For people not wanting to use the suggested profile, please using the following start and end gcodes. These also work with SuperSlicer and Orca Slicer

## Start
```
M104 S0
M190 S0
M98 P"start_print.g" A[first_layer_bed_temperature] B"[filament_type]" C[first_layer_temperature] D[nozzle_diameter]
```

## End
```
M0
```