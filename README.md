# Code da B34T

Two bars loop made with Ruby for [Sonic Pi](https://sonic-pi.net/), this uses synths to model each instrument.


## Rythm

### Score

![Punchis-punchis](/score.svg)

### Tab

```
HH||  X-x-X-x-X-x-X-x-|X-x-X-x-X-x-X-x-  ||
 S||: ----o-------o---|----o-----o-o--- :||
BD||  o---o---o---o-o-|o---o---o---o-o-  ||
      1 + 2 + 3 + 4 +  1 + 2 + 3 + 4 +
```

## Instruments

### Bass Drum (_kick_)

- Osc 1:
    - Tiangle wave
    - 150.05hz
    - Release: 0.7
    - Amp: 0.7
    - Slide to: 50.03hz
    - Slide time: 0.25
- Osc 2:
    - Tiangle wave
    - 50.07hz
    - release: 0.1
    - Amp: 0.5
- LPF:
    - Cutoff: note 110
    - Slide to: note 60
    - Slide time: 0.1

### Snare

- Osc 1:
    - Sine wave
    - 400.1hz
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

### Global HPF
- Cutoff: 50hz

