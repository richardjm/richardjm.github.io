# Home Assistant

## Features

- Home power monitoring
- Notifications for tumble drier and washing machine finished
- [Klipper](klipper) integration
- [PixelIt](pixelit) display

### Notify
`scripts.notify`

Generic notify script that speaks a message via Alexa, flashes lights
and sends notifications to phones.

```yaml
alias: Notify
sequence:
  - variables:
      _colour: "{{ colour | default('white') | lower }}"
      _red: |-
        {% if _colour in ['red', 'yellow', 'violet', 'white'] %}
          255
        {% else %}
          0
        {% endif %}
      _green: |-
        {% if _colour in ['green', 'yellow', 'cyan', 'white'] %}
          255
        {% else %}
          0
        {% endif %}
      _blue: |-
        {% if _colour in ['blue', 'violet', 'cyan', 'white'] %}
          255
        {% else %}
          0
        {% endif %}
  - parallel:
      - service: notify.alexa_media
        data:
          target:
            - media_player.lounge
            - media_player.kitchen
          data:
            method: all
            type: announce
          message: "{{ message }}"
        enabled: true
      - if:
          - condition: template
            value_template: "{{ richard }}"
        then:
          - service: notify.mobile_app_richard_s_phone
            data:
              message: "{{ message }}"
      - service: script.flash_ceiling
        data:
          lights:
            entity_id:
              - light.ceiling
          red: "{{ _red }}"
          green: "{{ _green }}"
          blue: "{{ _blue }}"
      - service: rest_command.pixelit_message
        data:
          message: "{{ message }}"
          red: "{{ _red }}"
          green: "{{ _green }}"
          blue: "{{ _blue }}"
      - if:
          - condition: time
            after: "06:25:00"
            before: "21:00:00"
            weekday:
              - mon
              - tue
              - wed
              - thu
              - fri
              - sat
              - sun
        then:
          - service: notify.alexa_media
            data:
              target:
                - media_player.lounge
                - media_player.kitchen
                - media_player.workshop
              data:
                method: all
                type: announce
              message: "{{ message }}"
        enabled: false
mode: queued
icon: mdi:bell-alert
fields:
  message:
    description: Message
    required: true
    selector:
      text: null
  richard:
    description: Notify Richard
    required: true
    selector:
      boolean: null
  colour:
    description: Colour
    required: true
    selector:
      select:
        options:
          - Red
          - Green
          - Blue
          - Yellow
          - Violet
          - Cyan
          - White
max: 10
```

### Flash lights
`scripts.flash_ceiling`

```yaml
alias: Flash light if somebody is home
sequence:
  - condition: numeric_state
    entity_id: zone.home
    above: "0"
  - variables:
      _red: "{{ red | default(128) }}"
      _green: "{{ green | default(128) }}"
      _blue: "{{ blue | default(128) }}"
      _onFor: |-
        {% if (duration | default(0)) > 0 and (dutycycle | default(0)) > 0 %}
          {{ (duration * (dutycycle / 100)) | int }}
        {% else %}
          500
        {% endif %}
      _offFor: |-
        {% if (duration | default(0)) > 0 and (dutycycle | default(0)) > 0  %}
          {{ (duration * ((100 - dutycycle) / 100)) | int }}
        {% else %}
          500
        {% endif %}
  - service: scene.create
    data:
      scene_id: temp_flash_light
      snapshot_entities: "{{ states.light | map(attribute='entity_id') | join(',') }}"
  - repeat:
      count: "{{ count | default(5) }}"
      sequence:
        - service: light.turn_on
          target: "{{ lights }}"
          data:
            rgb_color:
              - "{{ _red }}"
              - "{{ _green }}"
              - "{{ _blue }}"
            brightness: "{{ max(_red, _green, _blue) }}"
        - delay:
            hours: 0
            minutes: 0
            seconds: 0
            milliseconds: "{{ _onFor }}"
        - service: light.turn_off
          target: "{{ lights }}"
        - delay:
            hours: 0
            minutes: 0
            seconds: 0
            milliseconds: "{{ _offFor }}"
  - service: scene.turn_on
    target:
      entity_id: scene.temp_flash_light
    data: {}
fields:
  lights:
    description: Lights
    required: true
    selector:
      target:
        entity:
          domain: light
  red:
    description: Red
    default: 128
    example: 255
    selector:
      number:
        min: 0
        max: 255
  green:
    description: Green
    default: 128
    example: 0
    selector:
      number:
        min: 0
        max: 255
  blue:
    description: Blue
    default: 128
    example: 0
    selector:
      number:
        min: 0
        max: 255
  count:
    description: Number of cycles
    default: 5
    example: 3
    selector:
      number:
        min: 1
        max: 10
  duration:
    description: Duration of each cycle in ms
    default: 1000
    example: 2000
    selector:
      number:
        min: 1
        max: 30000
  dutycycle:
    description: Duty cycle, percentage of time light is on for in each cycle
    default: 50
    example: 10
    selector:
      number:
        min: 1
        max: 99
mode: queued
max: 10
```