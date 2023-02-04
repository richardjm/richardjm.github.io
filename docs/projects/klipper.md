# Klipper in Home Assistant

Connects and polls moonraker and reveals many settings via home assistant.

Also allows executing macros easily.

![](/img/ha_klipper.png)

## Main sensors
```yaml
rest:
  - resource: http://X.X.X.X/printer/objects/query?extruder=temperature,target&heater_bed=temperature,target&temperature_host%20pi&temperature_sensor%20enclosure_temp=temperature&display_status
    scan_interval: 5
    timeout: 1
    sensor:
      - name: Voron2 extruder temperature
        unique_id: rest_v2_extruder_temp
        value_template: "{{ value_json.result.status.extruder.temperature }}"
        unit_of_measurement: "°C"
        state_class: measurement
        device_class: temperature
      - name: Voron2 extruder target
        unique_id: rest_v2_extruder_target
        value_template: "{{ value_json.result.status.extruder.target }}"
        unit_of_measurement: "°C"
        state_class: measurement
        device_class: temperature
      - name: Voron2 bed temperature
        unique_id: rest_v2_bed_temp
        value_template: "{{ value_json.result.status.heater_bed.temperature }}"
        unit_of_measurement: "°C"
        state_class: measurement
        device_class: temperature
      - name: Voron2 bed target
        unique_id: rest_v2_bed_target
        value_template: "{{ value_json.result.status.heater_bed.target }}"
        unit_of_measurement: "°C"
        state_class: measurement
        device_class: temperature
      - name: Voron2 chamber temperature
        unique_id: rest_v2_chamber_temp
        value_template: "{{ value_json.result.status['temperature_sensor enclosure_temp'].temperature }}"
        unit_of_measurement: "°C"
        state_class: measurement
        device_class: temperature
      - name: Voron2 pi temperature
        unique_id: rest_v2_pi_temp
        value_template: "{{ value_json.result.status['temperature_host pi'].temperature }}"
        unit_of_measurement: "°C"
        state_class: measurement
        device_class: temperature
      - name: Voron2 progress
        unique_id: rest_v2_progress
        value_template: "{{ (value_json.result.status.display_status.progress * 100) | round() }}"
        unit_of_measurement: "%"
      - name: Voron2 message
        unique_id: rest_v2_message
        value_template: >-
          {% if value_json.result.status.display_status.message is defined and value_json.result.status.display_status.message and value_json.result.status.display_status.message != "" %}
            {{ value_json.result.status.display_status.message }}
          {% else %}
            {{ 'Empty' }}
          {% endif %}
  - resource: http://X.X.X.X/printer/info
    scan_interval: 5
    timeout: 1
    sensor:
      - name: Voron2 state message
        unique_id: rest_v2_state_message
        value_template: "{{ value_json.result.state_message }}"
```

## Nicer icons by default
```yaml
omeassistant:
  customize:
    sensor.voron2_bed_target:
      icon: mdi:radiator
    sensor.voron2_bed_temperature:
      icon: mdi:radiator-disabled
    sensor.voron2_extruder_target:
      icon: mdi:printer-3d-nozzle-heat
    sensor.voron2_extruder_temperature:
      icon: mdi:printer-3d-nozzle-alert
    sensor.voron2_pi_temperature:
      icon: mdi:raspberry-pi
```

## Run macros
```yaml
rest_command:
  voron2_gcode:
    url: http://X.X.X.X/printer/gcode/script?script={{gcode}}
    method: post
  voron2_shutdown:
    url: http://X.X.X.X/machine/shutdown
    method: post
    timeout: 30
```

## Dashboard
```yaml
  - theme: Backend-selected
    icon: mdi:printer-3d-nozzle
    title: Printing
    badges: []
    cards:
      - type: conditional
        conditions:
          - entity: switch.printer
            state: 'off'
        card:
          show_name: false
          show_icon: true
          type: button
          tap_action:
            action: toggle
          entity: switch.printer
          icon_height: 35px
          show_state: false
      - type: vertical-stack
        cards:
          - type: horizontal-stack
            cards:
              - show_name: false
                show_icon: true
                type: button
                tap_action:
                  action: url
                  url_path: https://github.com/richardjm
                icon: mdi:github
                icon_height: 35px
                name: GitHub
                show_state: false
              - show_name: false
                show_icon: true
                type: button
                tap_action:
                  action: url
                  url_path: https://www.klipper3d.org/G-Codes.html
                icon: mdi:help-network-outline
                icon_height: 35px
                name: Klipper
                show_state: false
              - show_name: false
                show_icon: true
                type: button
                tap_action:
                  action: call-service
                  service: rest.reload
                  data: {}
                  target: {}
                entity: input_button.reload_restful
              - show_name: false
                show_icon: true
                type: button
                tap_action:
                  action: url
                  url_path: https://moonraker.readthedocs.io/en/latest/
                icon: mdi:rocket-launch-outline
                icon_height: 35px
                name: Moonraker
                show_state: false
              - show_name: false
                show_icon: true
                type: button
                tap_action:
                  action: url
                  url_path: http://wled-v2-1906/
                icon: mdi:led-strip-variant
              - show_name: false
                show_icon: true
                type: button
                tap_action:
                  action: toggle
                entity: input_boolean.voron_safe_shutdown
                show_state: false
                icon_height: 25px
          - type: entity
            entity: sensor.voron2_message
          - type: entity
            entity: sensor.voron2_state_message
          - type: glance
            entities:
              - entity: sensor.voron2_extruder_temperature
                name: Extruder
              - entity: sensor.voron2_extruder_target
                name: Target
              - entity: sensor.voron2_bed_temperature
                name: Bed
              - entity: sensor.voron2_bed_target
                name: Target
              - entity: sensor.voron2_pi_temperature
                name: Pi
            show_name: true
            state_color: true
          - type: entity
            entity: sensor.voron2_progress
      - type: conditional
        conditions:
          - entity: switch.printer
            state: 'on'
        card:
          type: vertical-stack
          cards:
            - show_name: true
              show_icon: false
              type: button
              tap_action:
                action: url
                url_path: http://X.X.X.X/
              entity: ''
              name: http://X.X.X.X/
            - type: horizontal-stack
              cards:
                - show_name: false
                  show_icon: true
                  type: button
                  tap_action:
                    action: call-service
                    service: rest_command.voron2_gcode
                    service_data:
                      gcode: G28
                    target: {}
                  entity: ''
                  icon: mdi:home
                  icon_height: 35px
                - show_name: false
                  show_icon: true
                  type: button
                  tap_action:
                    action: call-service
                    service: rest_command.voron2_gcode
                    service_data:
                      gcode: QUAD_GANTRY_LEVEL
                    target: {}
                  entity: ''
                  icon_height: 35px
                  name: QGL
                  icon: mdi:spirit-level
                - show_name: false
                  show_icon: true
                  type: button
                  tap_action:
                    action: call-service
                    service: rest_command.voron2_gcode
                    service_data:
                      gcode: RESETRGB
                    target: {}
                  icon_height: 35px
                  icon: mdi:lightbulb
                - show_name: false
                  show_icon: true
                  type: button
                  tap_action:
                    action: call-service
                    service: rest_command.voron2_gcode
                    target: {}
                    data:
                      gcode: LIGHTS_OFF
                  entity: ''
                  icon_height: 35px
                  icon: mdi:lightbulb-off-outline
                - show_name: false
                  show_icon: true
                  type: button
                  tap_action:
                    action: call-service
                    service: rest_command.voron2_gcode
                    service_data:
                      gcode: PREPARE_PRINT
                    target: {}
                  entity: ''
                  icon_height: 35px
                  icon: mdi:fire
                - show_name: false
                  show_icon: true
                  type: button
                  tap_action:
                    action: call-service
                    service: rest_command.voron2_gcode
                    service_data:
                      gcode: COOLDOWN
                    target: {}
                  entity: ''
                  icon_height: 35px
                  icon: mdi:snowflake
      - type: conditional
        conditions:
          - entity: switch.printer
            state: 'on'
        card:
          type: history-graph
          hours_to_show: 1
          entities:
            - entity: sensor.voron2_extruder_temperature
              name: Extruder
            - entity: sensor.voron2_bed_temperature
              name: Bed
            - entity: sensor.voron2_chamber_temperature
              name: Chamber
          refresh_interval: 5
      - type: conditional
        conditions:
          - entity: switch.printer
            state: 'on'
        card:
          show_state: false
          show_name: true
          camera_view: live
          type: picture-entity
          entity: camera.voron2_2
          tap_action:
            action: url
            url_path: http://X.X.X.X/
          name: Voron v2.1906
      - type: conditional
        conditions:
          - entity: switch.printer
            state: 'on'
        card:
          type: gauge
          entity: sensor.printer_current_power
          needle: true
          min: 0
          max: 600
          severity:
            green: 10
            yellow: 100
            red: 300
          name: Printer
      - chart_type: line
        period: 5minute
        days_to_show: 1
        type: statistics-graph
        entities:
          - sensor.printer_current_power
        stat_types:
          - mean
      - type: entities
        entities:
          - entity: light.v2_1906_master
          - entity: select.v2_1906_preset
        title: Printer lights
        show_header_toggle: false
        state_color: true
```

## Voron safe shutdown
Automation to shutdown and then turn off printer.

```yaml
alias: Voron 2.4 safe shutdown if requested
description: ""
trigger:
  - platform: numeric_state
    entity_id: sensor.voron2_bed_temperature
    below: "43"
  - platform: state
    entity_id:
      - input_boolean.voron_safe_shutdown
condition:
  - condition: state
    entity_id: input_boolean.voron_safe_shutdown
    state: "on"
  - condition: numeric_state
    entity_id: sensor.voron2_bed_temperature
    below: "43"
action:
  - service: script.notify
    data:
      message: 3 D printer safe shutdown is now possible
      colour: Violet
      maria: false
      richard: true
    enabled: false
  - service: input_boolean.turn_off
    data: {}
    target:
      entity_id: input_boolean.voron_safe_shutdown
  - service: script.shutdown_3d_printer
    data: {}
mode: single
```

`automation.shutdown_3d_printer`

```yaml
alias: Shutdown Voron 2.4
sequence:
  - if:
      - condition: numeric_state
        entity_id: sensor.voron2_bed_temperature
        above: "43"
    then:
      - service: script.notify
        data:
          richard: true
          message: Attempt to shutdown 3d printer failed, bed temperature is too high
          colour: Red
    else:
      - service: rest_command.voron2_shutdown
        data: {}
      - delay:
          hours: 0
          minutes: 0
          seconds: 20
          milliseconds: 0
      - type: turn_off
        device_id: XXX
        entity_id: switch.printer
        domain: switch
      - service: script.notify
        data:
          richard: true
          message: 3d printer shutdown and turned off
          colour: Green
mode: single
icon: mdi:printer-3d-nozzle-off
```