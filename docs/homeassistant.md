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

### Broadlink codes

With the help of learning from my existing remotes and for roku information on the codes from [RemoteCentral.com](https://files.remotecentral.com/library/3-2/roku_labs/media_player/2016_models/index.html) and using the [Sensus IR & RF Code Coverter](https://pasthev.github.io/sensus/).

- TV Samsung
- Soundbar Yamaha
- Roku 4200X - Roku 3

```json
{
  "version": 1,
  "minor_version": 1,
  "key": "broadlink_remote_ec0baea38ef7_codes",
  "data": {
    "television": {
      "power": "JgDSAJSUFTYUNhQ1ExIVERQRFBEUERM2FDYVNRUPFRATExQRERQSExQ1FRETERQRERQUERQRETcVEhQ1FTQTNxY0FjQVNRUABgCWkhQ2EzcUNhMTExISExISExMSNxM3EzcTEhMSEhMUERITEhITNhQTEhITEhITExISExI2FBIUNRQ2FTUUNhQ2FTUUAAYBlJQUNhU1FTUVEBQSFBETERQSEzUTNxM3FREUERQRExIUERMRFDUVEREUFBEUEBQSFBEQORQRETgVNRU1FTUVNRU1EwANBQAAAAAAAA==",
      "input": "JgDSAJaSETkTNxI4FBERFBMTERMSExA5EzcSOBIUFBESExAUERQRORM2FRIRNxQSEhMQFRE4ExMSERI4EhMVNRI4EjgUExIABgGWkhE5ETkSNxURERQRExURERMRORQ2EjgSExQREhQQFBEUEDkUNhEUEjgVEREUEBQUNRIVEBQROBURETgSOBI4EhQQAAYElpEVNRI4EjgSFRAUERQQFREUEDkRORI4EhQQFBEUERQRFBA5ETkSFBA5ERQSExEUEzYSFBQRETgSFBE4EjgSOBIUEAANBQAAAAAAAA=="
    },
    "soundbar": {
      "power": "JgBQAAABJ5MTExITEhMTNhM3EjcTNhMTETgTNhM2FBITEhMSEhMTNxITExITNhM3ExITEhM2EzcTNhM3EhMTEhM2EjgTEhMSEwAFGwABJ0oTAA0FAAAAAAAAAAA=",
      "mute": "JgBYAAABKZEVERQRFBEUNRQ1FTUUNRURFDUUNRU1FBEUERQRFBEVNRQRFBEUNRU1FDUUERUQFTUUNRU0FREUEhMSEzUVNRQRFAAFGgABKUgUAAxMAAEpSBQADQU=",
      "volume up": "JgBQAAABKZEUERUQFREUNRQ1FTUUNRQRFDYUNRQ1FREUERQRFBEUNRURFDUUNRU1FDUUERURFBEUNRQRFBEVEBURFDUUNRU1FAAFGgABKUgUAA0FAAAAAAAAAAA=",
      "volume down": "JgBQAAABKZEUERUQFREUNRQ1FTUUNRQRFTUUNRQ1FREUERQRFBEUNRU1FDUUNhQ1FDUVERQRFBEUERQRFBEVEBURFDUUNRU1FAAFGgABKUgUAA0FAAAAAAAAAAA=",
      "bluetooth": "JgBQAAABKZEVEBURFBEUNRQ1FTUUNRUQFTUUNRU0FREUERQRFBEUNRU1FBEUERQ1FREUNRQRFRAVEBU1FDUVEBU1FBEUNRU1FAAFGgABKUcVAA0FAAAAAAAAAAA=",
      "tv": "JgBQAAABJ5MUERMSExMTNhM2EzcTNhITEzcTNhI3ExMTEhITExISNxI4EzYTNhI4EjcSExI4EjcTEhIUERQSExIUETcSExIUEgAFHAABJkoSAA0FAAAAAAAAAAA=",
      "surround": "JgBQAAABJpQSExITEhMSOBI3EjcSOBITEjcSOBI3EhMSExIUEhMSNxITEhMSOBITEjcSOBITEjcSOBI3EhMSNxMTEhMSNxITEgAFHQABJkoSAA0FAAAAAAAAAAA=",
      "stereo": "JgBQAAABKZEUERURFBISNhQ1FDYUNRQRFDYUNRQ1FREUERQRFBETNhQSExIUERQREzYUEhM2ExITNhM3EzYTNxMSEzYSExI4EgAFHAABJksSAA0FAAAAAAAAAAA="
    },
    "roku": {
      "* menu": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhISEhISNxI3EhISEhI3EjcSNxI3EhISEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhISEhISNxI3EjcSEhI3EjcSNxI3EhISEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhISEhISNxI3EjcSEhI3EjcSNxI3EhISEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "back": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxISEhISNxI3EhISNxISEhISNxI3EhISEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxISEhISNxI3EjcSNxISEhISNxI3EhISEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxISEhISNxI3EjcSNxISEhISNxI3EhISEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "down": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEjcSNxISEhISEhISEjcSNxISEhISNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEjcSNxISEjcSEhISEjcSNxISEhISNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEjcSNxISEjcSEhISEjcSNxISEhISNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "fast foward": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxISEjcSEhI3EhISEhI3EhISNxISEjcSEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxISEjcSEhI3EjcSEhI3EhISNxISEjcSEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxISEjcSEhI3EjcSEhI3EhISNxISEjcSEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "home": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEhISEhISEhISEhISEjcSNxI3EjcSNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEhISEhISEjcSEhISEjcSNxI3EjcSNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEhISEhISEjcSEhISEjcSNxI3EjcSNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "left": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxI3EjcSEhISEhISNxISEhISEhISEjcSNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxI3EjcSEhISEjcSNxISEhISEhISEjcSNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxI3EjcSEhISEjcSNxISEhISEhISEjcSNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "ok": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSEhI3EhISNxISEhISNxISEjcSEhI3EhISNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSEhI3EhISNxISEjcSNxISEjcSEhI3EhISNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSEhI3EhISNxISEjcSNxISEjcSEhI3EhISNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "play pause": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxI3EhISEhI3EhISNxI3EhISEhI3EjcSEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxI3EhISEhI3EjcSNxI3EhISEhI3EjcSEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxI3EhISEhI3EjcSNxI3EhISEhI3EjcSEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "rewind": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxISEjcSNxISEhISNxI3EhISNxISEhISNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxISEjcSNxISEjcSNxI3EhISNxISEhISNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxISEjcSNxISEjcSNxI3EhISNxISEhISNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "right": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxI3EhISNxISEhISEhI3EhISEhI3EhISNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxI3EhISNxISEjcSEhI3EhISEhI3EhISNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxI3EhISNxISEjcSEhI3EhISEhI3EhISNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "up": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhI3EjcSEhISEhISEhI3EjcSEhISEjcSNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhI3EjcSEhISEjcSEhI3EjcSEhISEjcSNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhI3EjcSEhISEjcSEhI3EjcSEhISEjcSNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "instant replay": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISEhI3EjcSNxI3EhISNxI3EjcSEhISEhISEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISEhI3EjcSNxI3EjcSNxI3EjcSEhISEhISEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISEhI3EjcSNxI3EjcSNxI3EjcSEhISEhISEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA="
    }
  }
}
```

Then a script to make calling the codes a little easier, perhaps.

```yaml
sequence:
  - action: remote.send_command
    metadata: {}
    data:
      num_repeats: 1
      delay_secs: 0.4
      hold_secs: 0
      device: "{{ button.split(' - ')[0] }}"
      command: "{{ button.split(' - ')[1] }}"
    target:
      entity_id: remote.remote
fields:
  button:
    selector:
      select:
        options:
          - television - power
          - television - input
          - roku - * menu
          - roku - home
          - roku - back
          - roku - up
          - roku - down
          - roku - left
          - roku - right
          - roku - ok
          - roku - instant replay
          - roku - rewind
          - roku - play pause
          - roku - fast forward
          - soundbar - bluetooth
          - soundbar - mute
          - soundbar - power
          - soundbar - stereo
          - soundbar - surround
          - soundbar - tv
          - soundbar - volume up
          - soundbar - volume down
alias: Remote Send
description: ""
icon: mdi:remote
```
