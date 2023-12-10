# ERCF set-up

## Overview

For now I'm removing my ERCF as I don't use it enough and the filament buffer
makes it much harder to move the printer around.

Recording my set-up here in case I need to recover things, especially with
my slicer configuration

## ERCF Uninstallation

```sh
cd ERCF-Software-V3
./install.sh -u
```

## Slicer settings

Printer > General > Capabilities

```text
Extruders: 9
Single Extruder Multi Material: checked
```

### Start G-code

```text
_SET_TOOL_COLOR TOOL=0 COLOR={extruder_colour[0]}
_SET_TOOL_COLOR TOOL=1 COLOR={extruder_colour[1]}
_SET_TOOL_COLOR TOOL=2 COLOR={extruder_colour[2]}
_SET_TOOL_COLOR TOOL=3 COLOR={extruder_colour[3]}
_SET_TOOL_COLOR TOOL=4 COLOR={extruder_colour[4]}
_SET_TOOL_COLOR TOOL=5 COLOR={extruder_colour[5]}
_SET_TOOL_COLOR TOOL=6 COLOR={extruder_colour[6]}
_SET_TOOL_COLOR TOOL=7 COLOR={extruder_colour[7]}
_SET_TOOL_COLOR TOOL=8 COLOR={extruder_colour[8]}
PRINT_START HOTEND={first_layer_temperature[initial_extruder] + extruder_temperature_offset[initial_extruder]} BED=[first_layer_bed_temperature] CHAMBER=[chamber_temperature] TOOL=[initial_extruder]
SET_PRESSURE_ADVANCE ADVANCE=0.02 SMOOTH_TIME=0.04
PRIME_LINE
```

### End G-code

```text
PRINT_END UNLOAD_AT_END=0
```

## Klipper macros

### PRINT_START

```text
...
INITIAL_LOAD_LOCATION                     ; Move to the best location for loading filament
T{tool}
CLEAN_NOZZLE PURGE=1 PURGE_LEN=5 MOVE=0   ; load filament, purge and clean
...
```

### PRINT_END

The unload at end has to go.

```text
[gcode_macro PRINT_END]
description: Run after a print is finished, keep the printer ready to go again
gcode:
    {% set unload = params.UNLOAD_AT_END|default(0)|int %}
    M400                           ; wait for buffer to clear
    G92 E0                         ; zero the extruder
    G1 E-1.0 F3600                 ; retract filament
    G91                            ; relative positioning
    G0 Z1.00 X20.0 Y20.0 F20000    ; move nozzle to remove stringing
    ; TURN_OFF_HEATERS
    SET_HEATER_TEMPERATURE HEATER=heater_bed TARGET={printer['heater_bed'].target|int - 5}
    SET_HEATER_TEMPERATURE HEATER=extruder TARGET=50
    PARK                           ; park nozzle at rear, over nozzle cleaning area
    {% if unload|int == 1 %}
      ERCF_EJECT
    {% endif %}
    # CLEAN_NOZZLE
    # BED_MESH_CLEAR
    M117 Complete
```

## RESUME

```text
[gcode_macro RESUME]
rename_existing: BASE_RESUME
variable_zhop: 0
variable_etemp: 0
gcode:
    # Parameters
    {% set e = params.E|default(0)|int %}                                                          ; nozzle prime amount

    {% if printer['pause_resume'].is_paused|int == 1 %}

        {% if printer.ercf.is_paused|int == 1 %}
            M118 You can't resume the print without unlocking the ERCF first.
            M118 Run ERCF_UNLOCK and solve any issue before hitting Resume again
        {% endif %}
        
        ...

        M117 Printing

        {% if printer.ercf.clog_detection|int == 1 %}
            SET_FILAMENT_SENSOR SENSOR=toolhead_sensor ENABLE=1
        {% endif %}

        BASE_RESUME
    {% endif %}
```

### INITIAL_LOAD_LOCATION

```text
[gcode_macro INITIAL_LOAD_LOCATION]
description: Go to the best home location for loading the filament at the start of the print which keeps the bowden as straight as possible
gcode:
    G90
    G0 X125 Y10 Z5 F12000
```

### Coloured buttons in mainsail

In a separate macro file called `filament.cfg` in my case.

```text
############################################################################
# Complementary macros controlling variables used by mainsail for display
############################################################################

# Requires named variables in your tool change macros that are used by mainsail
# [gcode_macro T0]
# variable_active: 0
# variable_color: "undefined"

[gcode_macro _SET_ACTIVE_TOOL]
description: Sets the active tool in mainsail (and all others inactive)
gcode:
  {% set TOOL = params.TOOL|default(-1)|int %}
  {% for T in range(9) %}
    {% if T == TOOL %}
      SET_GCODE_VARIABLE MACRO=T{T} VARIABLE=active VALUE=1
    {% else %}
      SET_GCODE_VARIABLE MACRO=T{T} VARIABLE=active VALUE=0
    {% endif %}
  {% endfor %}

# _SET_TOOL_COLOR TOOL=<id> COLOR=<color>
# e.g. _SET_TOOL_COLOR TOOL=0 COLOR=#112233
[gcode_macro _SET_TOOL_COLOR]
description: Sets a color for mainsail extruder
gcode:
  {% set tool = params.TOOL|default(-1)|int %}
  # get color from rawparams and and remove the # char from the color code if present
  {% set ns = namespace(color="undefined") %}
  {% for param in rawparams.split(' ') %}
    {% if 'COLOR' in param|string|upper %}
      {% set rawcolor = (param.split('='))[1] %}
      {% set ns.color = rawcolor if rawcolor[0]|lower in ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'] else rawcolor[1:] %}
    {% endif %}
  {% endfor %}
  SET_GCODE_VARIABLE MACRO=T{tool} VARIABLE=color VALUE='"{ns.color}"'
  # Requires [save_variables], for me this is provided by ercf
  {% if printer.save_variables is defined %}
    SAVE_VARIABLE VARIABLE=t{tool}_color VALUE='"{ns.color}"'
  {% endif %}

# Reload the colors from the [save_variables] if used
[delayed_gcode _SET_TOOL_COLORS_ON_STARTUP]
initial_duration: 1
gcode:
  {% set svv = printer.save_variables.variables %}
  {% for T in range(9) %}
    _SET_TOOL_COLOR TOOL={T} COLOR={svv['t' + (T|string) + '_color']}
  {% endfor %}
```
