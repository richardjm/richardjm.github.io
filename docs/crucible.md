# Crucible

A v0/trident hybrid by Maverick - <https://github.com/PrintersForAnts/Crucible>

Slight variant by me - <https://github.com/richardjm/Crucible/tree/richardjm/variation>

My build in progress klipper backup is at <https://github.com/richardjm/crucible-klipper-backup>

- Reduction in branding
- Changed colours (primary, accent, touch)
- Exported STLs
- Different skirt (wip)
- Mini-Stealthburner
- Various clip sizes panels
- Smaller hole for screw into plastic idler in a/b mounts
- Sensorless x/y
- Changed base plate dxf
- Klicky on right to avoid clash with z-chain
- Tools
  - Drill guides
  - Grantry positioning tool
  - MGN9 1515 rail guide
  - MGN7 1515 rail guide

In the usermods folder:

- Canbus mount for Mellow fly sht36 v2
- Smaller x-carrage for a 17mm pancake motor
- Cover for front of bed
- Beefier left idler
- Sawtooth led mount
- Pointier rail stops to add range (wip)
- Shorter rear z motor mount (wip)
- UnKlickyNG BFP

**Be warned - this whole section is a work in progress and likely wrong.**

## Z assembly

### Lead screws

- **(3) NEMA17 Stepper Motor w/ integrated lead screw 200mm T8x8**
- (10) m3x30 shcs (bottom z to motors)
- (2) m3x35 shcs (bottom z to rear motor z-chain)
- **(3) m5x16 shcs (ge5c)**
- **(3) m5 nut or nyloc**
- **(3) ge5c x 3**
- (9) m3x6 bhcs (ge5c retainers)
- (4) m3x12 bhcs (leadscrew nut, cut circle)
- (2) m3x14 bhcs + nut (leadscrew nut - rear, full circle)
- (4) m2x6 shcs + washers (to rail)
- (4) m3x10 bhcs + nuts (recommend _no_drop_front_leadscrews.stl_)

TBC - screws for accent plates

### Bed Assembly

- (3) m3x8 bhcs + nuts (fans)
- (2) m3x8 shcs + nuts (rear)
- (4) m3x10 shcs + nuts (left+right)

TBC - screws for accent plates

## Gantry

### AB Motors

Per motor:

- (4) m3x35 shcs (to motor)
- (2) m3x30 shcs + (2) m3x6x0.5 shim (short stack)
- **(5) f623rs + (10) m3x6x0.5 shim**
- (2) m3x40 shcs + nuts (to side extrusion)
- (1) mx3x10 + nut (under mount to side extrusion)

### AB Idlers

- (2) m3x6 bhcs + nuts (frame)
- (2) m3x10 shcs + nuts (tensioner)
- (2) m3x6x0.5 shim + (2) f623rs + m3x40 + nut (bearing stack)
- (1) m3x25 shcs + heatset insert (tensioning arm)

### XY Joints

- (2) m3 heatset inserts
- (4) m2x6 shcs
- (3) m3x25 shcs
- (2) m3x10 bhcs + nuts
- (1) m3x8 bhcs + nut
- (4) f623rs + (4) m3x6x0.5 shim

**_Warning:_ This part is very hard to assemble. I got lucky by re-using some of my v0 extrusions that have a hole in that location I could use a follower to construct the stack and the push the m3x40 through the tensionsing arm and bearing stack in one. The last part attaching the tensioner to the side face of the front. Good luck.**

### Klicky

- (2) m3 heatset inserts
- (2) m3x6 + nuts (recommend _no_drop_double_nut.stl_)
- (2) m2x10 screws
- (8) 6x3mm magnets

## Frame

### 200mm extrusions

- (20) m2x10 bhcs (ends of 200mm extrusions)

### Rear

- (2) m3x14 shcs + nuts (middle rear to ab extrusion)
- (2) m3x8 shcs + nuts (middle rear to ab extrusion)
- (1) m3x20 shcs (when using mx3x20 variant)
- (1) m3x10 shcs (rear extrusion to bottom extrusion)

### Bed

- (1) m3x20 bhcs

## Mini Stealthburner

### Mellow Fly SHT36 v2

This is for the "usermod" flysht36-mount.

- (2) m3x8 bhcs
- (2) m3x8 shcs

### 17mm Pancake motor

As I'm using a 17mm pancake motor the x-carriage went on a diet in the
"usermod" carriage-slimmed.

For the -5.95 version.

- (1) m3x10
- (2) m3x40 + nyloc

## Braces (don't do this)

Per brace (I currently have 12 braces, I think you could put max 18)

- (1) m3x12 shcs
- (1) m3x18 shcs
- (1) m3x20 shcs
- (6) m3 nuts
