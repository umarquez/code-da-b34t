# Code da B34T

Two bars loop made with Ruby for [Sonic Pi](https://sonic-pi.net/), this uses synths to model each instrument.

[Listen here](https://soundcloud.com/umarquez/code-da-b34t/s-Jd9MpNrcVAb?si=34c5b5809867489688bd96484d28915f)

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
    - 200hz
    - Release: 0.7
    - Amp: 0.7
    - Slide to: 50hz
    - Slide time: 0.1
- Osc 2:
    - Tiangle wave
    - 50hz
    - release: 0.1
    - Amp: 0.5
- LPF:
    - Cutoff: 5000hz
    - Slide to: 250hz
    - Slide time: 0.1

### Snare

- Osc 1:
    - Sine wave
    - 400hz
    - Release 0.1
    - Amp: 0.15
    - Slide to: note 155hz
    - Slide time: 0.05
- Osc 2:
    - Sine wave
    - 600hz
    - Release 0.1
    - Amp: 0.15
    - Slide to: 303hz
    - Slide time: 0.05
- Osc 3:
    - White noise
    - Release 1
    - Cutoff: 1500hz
    - Env curve: 7
    - Amp: 0.5
- LPF:
    - Cutoff: 1500hz
    - Amp: 0.5

### Hi-hats

- Osc 1:
    - White noise
    - Release 0.3
    - Amp: 0.5 (_accented: 2_)
- HPF:
    - Cutoff: 15000hz
    - Mix: 1


## FX

### Global Reverb

- Room: 0.3
- Damp: 0.7

### Global HPF
- Cutoff: 50hz

# Apendix 1: Type of curves

- 1: linear
- 2: exponential
- 3: sine
- 4: welch
- ~5~: _not used_
- 6: squared
- 7: cubed 