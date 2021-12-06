# Punchis-punchis

Two bars loop made with Ruby for [Sonic Pi](https://sonic-pi.net/), this uses synths to model each instrument.

## Instruments

### Bass Drum (_kick_)

- Osc 1:
    - Tiangle wave
    - 150.01hz
    - Release 1.1
    - Slide to: 20hz
    - Slide time: 0.1
- Osc 2:
    - Sine wave
    - 50.1hz
    - release: 0.75
- LPF:
    - Cutoff: note 110
    - Slide to: note 40
    - Slide time: 0.1

### Snare

- Osc 1:
    - Sine wave
    - 300hz
    - Release 0.1
    - Amp: 0.15
- Osc 2:
    - Sine wave
    - 600hz
    - Release 0.1
    - Amp: 0.15
- Osc 3:
    - White noise
    - Release 0.5
    - Cutoff: note 100
    - Env curve: 7
- LPF:
    - Cutoff: note 110
    - Amp: 0.7

### High-hats

- Osc 1:
    - White noise
    - Release 0.3
    - Amp: 0.5 (_accented: 2_)
- HPF:
    - Cutoff: note 130
    - Mix: 1


## FX

### Global Reverb

- Room: 0.3
- Damp: 0.7


## Rythm

### Score

![Punchis-punchis](/punchis-punchis.svg)

### Tab

'''
HH||  X-x-X-x-X-x-X-x-|X-x-X-x-X-x-X-x-  ||
 S||: ----o-------o---|----o-------o--- :||
BD||  o---o---o---o-o-|o---o---o---o-o-  ||
      1 + 2 + 3 + 4 +  1 + 2 + 3 + 4 +
'''

