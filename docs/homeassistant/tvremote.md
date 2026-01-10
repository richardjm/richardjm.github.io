# TV Remote

I use a Broadlink RM mini 3 to control my tv, soundbard, roku and humax devices. So perhaps the codes below will help you or not. I have encapsulated my calls to the remote
into a single separate script which I can use a drop-down to send from other automations
without having to using magical strings.

I also haved configured some imitation screens for the physical remotes in home
assistant which can be used link the physical ones.

## Homepage quick commands

![alt text](/img/ha/remote-home.png)

```yaml
type: grid
cards:
  - type: horizontal-stack
    cards:
      - type: vertical-stack
        cards:
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: television - power
                icon: mdi:power
                icon_color: red
              - type: template
                icon: mdi:import
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: television - input
                content: TV Input
            grid_options:
              columns: 6
              rows: auto
          - type: custom:mushroom-chips-card
            chips:
              - type: template
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - power
                icon: mdi:power
                icon_color: red
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - mute
                icon: mdi:volume-mute
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - volume down
                icon: mdi:volume-minus
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - volume up
                icon: mdi:volume-plus
            grid_options:
              columns: 6
              rows: auto
        grid_options:
          columns: 6
          rows: auto
      - type: vertical-stack
        cards:
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - power
                icon_color: red
                icon: mdi:power
              - type: template
                tap_action:
                  action: navigate
                  navigation_path: /lovelace/humax
                icon: mdi:menu-open
                content: Humax
            grid_options:
              columns: 6
              rows: auto
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - play pause
                icon: mdi:play-pause
                icon_color: green
              - type: template
                content: Roku
                tap_action:
                  action: navigate
                  navigation_path: /lovelace/roku
                icon: mdi:menu-open
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - home
                icon: mdi:home-outline
            grid_options:
              columns: 6
              rows: auto
        grid_options:
          columns: 6
          rows: auto
    grid_options:
      columns: full
column_span: 4
visibility:
  - condition: numeric_state
    entity: zone.home
    above: 0
  - condition: numeric_state
    entity: sensor.ikea_kitchen_tretakt_plug_power
    above: 10
```

## Roku imitation remote

![alt text](/img/ha/remote-roku.png)

```yaml
type: sections
max_columns: 1
title: Roku
path: roku
icon: mdi:remote
sections:
  - type: grid
    cards:
      - type: vertical-stack
        cards:
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                hold_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - back
                icon: mdi:keyboard-backspace
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - home
                icon: mdi:home-outline
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - up
                icon: mdi:arrow-up-bold
                icon_color: purple
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - left
                icon: mdi:arrow-left-bold
                icon_color: purple
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - right
                icon: mdi:arrow-right-bold
                icon_color: purple
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - down
                icon: mdi:arrow-down-bold
                icon_color: purple
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - instant replay
                icon: mdi:replay
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - ok
                icon: mdi:checkbox-marked-circle
                icon_color: purple
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - * menu
                icon: mdi:asterisk
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - rewind
                icon: mdi:rewind
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - play pause
                icon: mdi:play-pause
                icon_color: green
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: roku - fast forward
                icon: mdi:fast-forward
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - mute
                icon: mdi:volume-mute
                icon_color: yellow
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - volume down
                icon: mdi:volume-minus
                icon_color: yellow
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - volume up
                icon: mdi:volume-plus
                icon_color: yellow
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
header:
  card:
    type: markdown
    text_only: true
    content: "# Roku"
cards: []
subview: true
```

## Humax imitation remote

![alt text](/img/ha/remote-humax.png)

```yaml
type: sections
max_columns: 1
subview: true
path: humax
title: Humax
icon: mdi:remote
sections:
  - type: grid
    cards:
      - type: vertical-stack
        cards:
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - record
                icon: mdi:record
                icon_color: red
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - pause
                icon: mdi:pause
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - play
                icon: mdi:play
                icon_color: green
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - stop
                icon: mdi:stop
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
            alignment: center
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - rewind
                icon: mdi:rewind
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - skip backward
                icon: mdi:skip-backward
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - skip forward
                icon: mdi:skip-forward
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - fast forward
                icon: mdi:fast-forward
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - red
                icon: mdi:solid
                icon_color: red
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - green
                icon: mdi:solid
                icon_color: green
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - yellow
                icon: mdi:solid
                icon_color: yellow
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - blue
                icon: mdi:solid
                icon_color: blue
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
            alignment: center
          - type: custom:mushroom-chips-card
            chips:
              - type: template
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - media
                content: Media
              - type: template
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - guide
                content: Guide
              - type: template
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - back
                content: Back
              - type: template
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - exit
                content: Exit
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
            alignment: center
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - left
                icon: mdi:arrow-left-bold
                icon_color: purple
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - right
                icon: mdi:arrow-right-bold
                icon_color: purple
              - type: template
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - ok
                content: OK
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - down
                icon: mdi:arrow-down-bold
                icon_color: purple
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - up
                icon: mdi:arrow-up-bold
                icon_color: purple
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - p down
                icon: mdi:chevron-double-down
              - type: action
                icon_color: yellow
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - mute
                icon: mdi:volume-mute
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - volume down
                icon: mdi:volume-minus
                icon_color: yellow
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: soundbar - volume up
                icon: mdi:volume-plus
                icon_color: yellow
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - p up
                icon: mdi:chevron-double-up
            alignment: center
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 1
                icon: mdi:numeric-1-circle-outline
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 2
                icon: mdi:numeric-2-circle-outline
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 3
                icon: mdi:numeric-3-circle-outline
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
            alignment: center
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 4
                icon: mdi:numeric-4-circle-outline
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 5
                icon: mdi:numeric-5-circle-outline
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 6
                icon: mdi:numeric-6-circle-outline
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
            alignment: center
          - type: custom:mushroom-chips-card
            chips:
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 7
                icon: mdi:numeric-7-circle-outline
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 8
                icon: mdi:numeric-8-circle-outline
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 9
                icon: mdi:numeric-9-circle-outline
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
            alignment: center
          - type: custom:mushroom-chips-card
            chips:
              - type: template
              - type: action
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - 0
                icon: mdi:numeric-0-circle-outline
              - type: template
                tap_action:
                  action: perform-action
                  perform_action: script.remote_send
                  target: {}
                  data:
                    button: pvr - opt+
                icon: mdi:plus
            card_mod:
              style: |
                ha-card {
                  --chip-height: 60px;
                  }
            alignment: center
header:
  card:
    type: markdown
    text_only: true
    content: "# Humax"
  layout: center
  badges_position: bottom
  badges_wrap: wrap
```

## Broadlink codes

With the help of learning from my existing remotes and for roku information on the codes from [RemoteCentral.com](https://files.remotecentral.com/library/3-2/roku_labs/media_player/2016_models/index.html) and using the [Sensus IR & RF Code Coverter](https://pasthev.github.io/sensus/).

- TV Samsung
- Soundbar Yamaha
- Roku 4200X - Roku 3
- Humax PVR

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
      "fast forward": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxISEjcSEhI3EhISEhI3EhISNxISEjcSEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxISEjcSEhI3EjcSEhI3EhISNxISEjcSEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxISEjcSEhI3EjcSEhI3EhISNxISEjcSEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "home": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEhISEhISEhISEhISEjcSNxI3EjcSNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEhISEhISEjcSEhISEjcSNxI3EjcSNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EjcSEhISEhISEhISEjcSEhISEjcSNxI3EjcSNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "left": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxI3EjcSEhISEhISNxISEhISEhISEjcSNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxI3EjcSEhISEjcSNxISEhISEhISEjcSNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSNxI3EjcSEhISEjcSNxISEhISEhISEjcSNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "ok": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSEhI3EhISNxISEhISNxISEjcSEhI3EhISNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSEhI3EhISNxISEjcSNxISEjcSEhI3EhISNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEjcSEhI3EhISNxISEjcSNxISEjcSEhI3EhISNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "play pause": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxI3EhISEhI3EhISNxI3EhISEhI3EjcSEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxI3EhISEhI3EjcSNxI3EhISEhI3EjcSEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxI3EhISEhI3EjcSNxI3EhISEhI3EjcSEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "rewind": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxISEjcSNxISEhISNxI3EhISNxISEhISNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxISEjcSNxISEjcSNxI3EhISNxISEhISNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISNxISEjcSNxISEjcSNxI3EhISNxISEhISNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "right": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxI3EhISNxISEhISEhI3EhISEhI3EhISNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxI3EhISNxISEjcSEhI3EhISEhI3EhISNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISNxI3EhISNxISEjcSEhI3EhISEhI3EhISNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "up": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhI3EjcSEhISEhISEhI3EjcSEhISEjcSNxI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhI3EjcSEhISEjcSEhI3EjcSEhISEjcSNxISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxI3EhISEhI3EjcSEhISEjcSEhI3EjcSEhISEjcSNxISEgAFGA0FAAAAAAAAAAAAAAAAAAA=",
      "instant replay": "JgDYAAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISEhI3EjcSNxI3EhISNxI3EjcSEhISEhISEhI3EgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISEhI3EjcSNxI3EjcSNxI3EjcSEhISEhISEhISEgAFGAABKJMSEhI3EhISNxISEjcSNxI3EhISNxISEhISEhISEjcSNxISEhISEhI3EjcSNxI3EjcSNxI3EjcSEhISEhISEhISEgAFGA0FAAAAAAAAAAAAAAAAAAA="
    },
    "pvr": {
      "up": "JgBUAAABKJQSExMSERMTERQRFBMSExETExEVEBQQFRISNhITEhISFBM2FBESExEUEzUVEhMSEhEVERQ0FTUUNRURETgROBE4EgAGKwABKEgVAAxVVgANBQAAAAA=",
      "down": "JgBgAAABKpEUEhITFBETEhQQEhMTEhQRFBESExITFBATNRURExMSEhUzFBEUNhQSEjYVERQRExEUERU0FRAVNBQRFDUUNRU1FAAGKAABKUgUAAxWAAEoSRUADFUAASdJFAANBQAAAAAAAAAA",
      "left": "JgBgAAABK5EVERQQFRAVEBUREhIUERQREhIVEBUREhMSNhUQExIVEBMSFDQVERMSEzYUERQRFBESNhURFDUVNBUQFTQVNBU0FgAGJwABK0YVAAxVAAEpSBUADFQAASlIFQANBQAAAAAAAAAA",
      "right": "JgBYAAABKJIVERQSEhEUEhQREhITEhQSExETEhMSFRASNhURExIVEBISFBEUNRQSFDQVEBQSFBEUNBQ1FRETNhUQFTMVNRQ1FAAGKQABKkcVAAxVAAEoSBUADQU=",
      "ok": "JgBgAAABKZIVERQRExEVERQREhMUEBMSExITERURFBETNRUQFRAVEBU0FTQVERMSFDQVERUQExEVEBUREjYVNBURFDQVNBU0FgAGJwABK0YVAAxVAAEpSBUADFQAASlIFQANBQAAAAAAAAAA",
      "power": "JgBQAAABKJETEhQQEhMVDxUPFBERExQRFQ8VDxUQFBAUNRUQFQ8UERQQFBEVDxUPFRAUEBITFBAVNBY0FDUVNRQ2FDUUNhQ1EwAGHAABKEgUAA0FAAAAAAAAAAA=",
      "guide": "JgBgAAABKZAUERQQFBETERQQFBEVDxQRExEUEBQRExEVNBQREhIUERU0EjgVDxQ2FDUSExQQFRARExQQFDYSEhQRFDUUNhU0FAAGGwABKUcTAAw9AAEpRhUADDwAAShHFAANBQAAAAAAAAAA",
      "media": "JgBgAAABKZAVEBETFBASExUPFBEVDxQQEhMVDxUQExETNhQRFBAUERQ1EjgSNxI4EhISOBI3EhMUEBITFBASEhM3FBAVEBI3EgAGHQABKEcUAAw9AAEpRhUADDsAAShIFQANBQAAAAAAAAAA",
      "exit": "JgBIAAABJpMSEhUQFBASExISEhISExISEhMUEBITExESNxITEhISEhITEjcSOBISEjgSEhUQFBAVNBITFBAVNRISEjgSNxI4FAANBQ==",
      "back": "JgBYAAABJpMUEBQRExEUERISFBAVEBISEhMTERMREhMSNxITExEVDxI4EhIVEBMRFRAUEBM2EhMSEhI4EjcSOBI3EjgSEhI4EgAGHQABJkkSAAw+AAEmShUADQU=",
      "p up": "JgBQAAABJpMSExQQEhIVEBQQEhMUEBUPFRASEhISEhMUNRITEhISExQQEhISExQQEjgSEhISFRASNxI4EjcSOBISEjgSNxI4EgAGHQABKUYWAA0FAAAAAAAAAAA=",
      "p down": "JgBQAAABKJEUEBUPEhMTERUPFBESEhITEhIUEBITFBAVNRISEhMSEhU0EjgSOBI3EhMUEBQQEhMUEBUQERMSEhI4EjcSOBI3EgAGHQABJkoSAA0FAAAAAAAAAAA=",
      "list": "JgBYAAABJpMSEhUQFBAVEBISEhIVEBQQFRAUEBISFRAUNRITEhISExM2EhIVNRI3ExIUEBQ2EhISExI3EhMTERU0EjgSExM2EgAGHQABJkkTAAw+AAEmSRQADQU=",
      "red": "JgBgAAABJpMSExQQEhMUEBISEhMSEhITFBASEhITEhISOBISEhISExISFBESNxI4EjcSExQQFBAUNhQ1FBEUEBQREzYSOBQ1FQAGGgABKUcUAAw8AAEpRxUADDsAAShHFgANBQAAAAAAAAAA",
      "green": "JgBYAAABJpMSExQQEhISExISEhIVEBQQExITERISEhMTNhITEhIVEBQ1EhISOBI2EzgSEhUQFBAUERI3EhMSEhUPFDYTNhI4EgAGHQABKUYWAAw7AAEoRxQADQU=",
      "yellow": "JgBYAAABJpMSEhUQFBASExQQEhIVEBQQEhISExISFRAUNRITExEVDxITFDUVEBQ1EjgSEhISExISNxITFDUSExQQFTUSNxI4EgAGHQABKUYUAAw9AAEpRhIADQU=",
      "blue": "JgBYAAABJpMTEhMREhIUERMRFBERExQQFBESEhQQEhMSNxQREhIVEBQQEjcUNhI4EjcSExQQEhIVNRISEhMUEBISEjgSNxM3EwAGHAABJkoSAAw+AAEpRhYADQU=",
      "play": "JgBcAAABKJAVEBQQFRESERQQFRAVDxUQExEUEBUQEhIUNhQQEhMUEBQQFRAUEBMSFBAUNRU1ExEVNRQ1FDYSOBQ1EhMRExM2FQAGGwABKEcUAAw8AAEnSRIADD7ZAA0FAAAAAAAAAAAAAAAA",
      "pause": "JgBYAAABKZASEhUPExIUEBQRExEUEBITFBAVEBMRFBAUNhISEhMTERQRFDUSEhITExEUNhI3EhMTNhUQEjcSOBI3EhMSEhI4EgAGHb4AA6GYAAOhkgADn4MADQU=",
      "stop": "JgBUAAABKZAVDxUQERMSEhUQFQ8VDxUQFQ8UERMRFQ8VNRQQFBEVDxQ2EzYVEBMRFBASOBI3FBEUEBITFDUUNhQ1FBERExQ2FQAGGocAA6J+AAOieAANBQAAAAA=",
      "record": "JgBUAAABKJEUEBQQFRAVDxUQFQ8UEBUQFBASExUPFQ8VNRQQFRAVDxQ2FBAVDxYPEhIUNhQ1FRAVDxQ2ETgVNRQ1FRAVDxU1FAAGG3MAA6NwAAOjagANBQAAAAA=",
      "rewind": "JgBQAAABKJESExMREhISExISFRAUEBISFBEVDxUQEhIVNRQQEhIVEBI3EhMSNxITFBASOBI3EhMUEBI3EhMVNBI4EhISExQ1EgAGHZwAA6KSAA0FAAAAAAAAAAA=",
      "fast forward": "JgBMAAABJpMUEBMSFBATERQRExESExISFBAUERMRFBESNxITExESEhQRExESOBISFBASOBI3ExISNxI4EhMTNhI3ExIUERQ1EgAGHYEADQUAAAAAAAAAAAAAAAA=",
      "skip backward": "JgBgAAABKpEVEBURFBESEhUQFRAVEBQRFBEVEBISExIVMxYREhIVEBUQFDQWNBUREhITNRY0FREVMxURFBETNRU0FREUEhM1FQAGKAABKEgVAAxVAAEoSBUADFYAAShIFQANBQAAAAAAAAAA",
      "skip forward": "JgBYAAABK5EVEBEUERMVEREUEBURFBQQERQRFBQREBURNxIUFBEQFBE4EjcSNxIVFRAUNBU0FREUEREUEhIRNxI4FhARFBA4FQAGKAABJkoTAAxYAAEmShIADQU=",
      "menu": "JgBgAAABKZITExMSExITEhMQFBEVEhQQFBETEhMSEhEUNhQRFBITERMSEzYTNhQ1FREUEhISExIUNBQSExITEhQ0FDUUNhQ1FAAGKQABKEgTAAxYAAEnSRUADFUAAShIFAANBQAAAAAAAAAA",
      "opt+": "JgBYAAABJ5QSFBITExIQFBQQFBITERITFBITEhAUExIUNRQRERQUERMSETcVEhAUFBEUERA4EhQUNBURFDUUNRU0FTUTExA4EgAGKwABKEgUAAxWAAEmShIADQU=",
      "sub": "JgAgAGAAA6RcAAOkWQADpFQAA6RTAAOkUQADpE8AA6RPAA0FAAAAAAAAAAA=",
      "1": "JgBgAAABJ5QVEREUFBERFBMRFBERFBQRERQRExUQERQROBIUERQUEBE3EjgSFBETFRAVERQRExITEREUETcSOBI3EjcSOBI3EgAGKwABKEgUAAxXAAEnSRMADFcAASZKFQANBQAAAAAAAAAA",
      "2": "JgBgAAABJ5UVEBQRFRATERISExMSEhMTEhMSExMREhMVNBYQFBASExMSFBEUNBMTExISExQREhMSNhM2FBIUNRU0FTUVNBU0FQAGKAABJ0kUAAxWAAEnSRQADFcAASdJFQANBQAAAAAAAAAA",
      "3": "JgBYAAABK5ASFRQQERQRFBQQERQVERAVFBASExEUEBQVNBIUEhMUEBU0FRERNxMTERQUEBEVEBUUEBI2EhQVNBI3EzYSOBI3EgAGKwABJ0oVAAxVAAEmShUADQU=",
      "4": "JgBgAAABK5EVEBITExEVERQRExITEhQQExIVEBQRExITNRQSFRAUEBQSEzUUNRQRFRETEhQRERMTNRUSFBETNRQ1FTUUNRQ1FQAGKAABKEkVAAxVAAEoSRQADFUAASZLFQANBQAAAAAAAAAA",
      "5": "JgBgAAABK5AWERISFRAVEBMRFBEVERMSEhIVEBUQExEUNRURFRASEhUzFTUUNRURFRAUEhMRFRATEhISFBEVNBQ1FTQWNBQ1FQAGKAABK0UVAAxWAAEoSBUADFUAAShIFgANBQAAAAAAAAAA",
      "6": "JgBgAAABJpQTExURFBASExEUFBARFBURExIUEBEUEhMUNBUREhMRFBQQERQSExQ1FREUEBITEhMROBU0FTQTEhU0EzYTNxM2EwAGKgABKkcVAAxVAAEnSRQADFYAAShIFQANBQAAAAAAAAAA",
      "7": "JgBgAAABKJMUEhUQEhMSEhMSFBEUERQRFRASEhMSFBEUNRURFBAVEBU0FBIUEBUzFREVEBQRExIVEBUzFTUVERI2FTQVNRU0FQAGJwABK0YVAAxVAAEoSBUADFYAAShIFAANBQAAAAAAAAAA",
      "8": "JgBgAAABK5EVDxYQFRAUERQRFBEVEBISExIVEBMSFBEUNBYQExEVERQRFDQVERQ0FREUERUQEhIVNBURFDQVERM1FTUVNBU0FQAGKAABKUgVAAxUAAEpSBUADFUAASlIFQANBQAAAAAAAAAA",
      "9": "JgBgAAABK5ETEhQQExITEhUQEhMSExQRERMTEhMSFRASNxMSExIVDxM3EzYTEhM3EhMUEBMSExMSEhUPEzcTEhM2EzcSNxM2EwAGKgABJ0kTAAxYAAEpRxMADFcAAShJEgANBQAAAAAAAAAA",
      "0": "JgBgAAABKZIVEBUQFRAUEhMSEhIVEBUQExEVEBQSEhMSNhUQFBEUERQRFBEUNBU0FRIUEBUQFRAVMxU1FRESEhU0FTQVNBU1FQAGJwABK0cUAAxVAAEpSBUADFQAASlIFQANBQAAAAAAAAAA",
      "tv portal": "JgAkADoAA6U3AAOlNAADpzcAA6QzAAOnNQADpTQAA6UxAAOoMAANBQAAAAA=",
      "i": "JgBgAAABKJIUERYRFBASExITFBAVEBUQExMUEBITEhMUNBUREhMSExI2EzcTExETEhMSExQ0FRESExITFDQVNRU0FTQVERE3EgAGKwABKkcSAAxYAAEmShIADFgAASZKEgANBQAAAAAAAAAA"
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
    required: true
    selector:
      select:
        options:
          - pvr - 0
          - pvr - 1
          - pvr - 2
          - pvr - 3
          - pvr - 4
          - pvr - 5
          - pvr - 6
          - pvr - 7
          - pvr - 8
          - pvr - 9
          - pvr - back
          - pvr - blue
          - pvr - down
          - pvr - exit
          - pvr - fast forward
          - pvr - green
          - pvr - guide
          - pvr - i
          - pvr - left
          - pvr - list
          - pvr - media
          - pvr - menu
          - pvr - ok
          - pvr - opt+
          - pvr - p down
          - pvr - p up
          - pvr - pause
          - pvr - play
          - pvr - power
          - pvr - record
          - pvr - red
          - pvr - rewind
          - pvr - right
          - pvr - skip backward
          - pvr - skip forward
          - pvr - stop
          - pvr - sub
          - pvr - tv portal
          - pvr - up
          - pvr - yellow
          - roku - * menu
          - roku - back
          - roku - down
          - roku - fast forward
          - roku - home
          - roku - instant replay
          - roku - left
          - roku - ok
          - roku - play pause
          - roku - rewind
          - roku - right
          - roku - up
          - soundbar - bluetooth
          - soundbar - mute
          - soundbar - power
          - soundbar - stereo
          - soundbar - surround
          - soundbar - tv
          - soundbar - volume down
          - soundbar - volume up
          - television - input
          - television - power
alias: Remote Send
description: ""
icon: mdi:remote
```