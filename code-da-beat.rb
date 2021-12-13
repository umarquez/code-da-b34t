
# ========================
# =[   Code  da  B34t   ]=
# ============ - @umarquez

# use_bpm sets the duration of a beat (whole unit) in times per minute.
# 120bpm == 0.5 of a second each
use_bpm 120


# Instruments:
# ------------
kick_enable = true
snare_enable = true
hh_enable = true

# - Bass drum (kick)
define :kick do
  if !kick_enable
    return
  end
  
  # LPF cuts the freqs above the cutoff point (5000hz) of the inner signals
  with_fx :lpf, cutoff: hz_to_midi(5000) do |lpf|
    # this automation moves the cutoff of the LPF to 250hz in a 0.1 of a beat
    # this will help to simulate the behavior of a membrane being hitten
    control lpf, cutoff: hz_to_midi(250), cutoff_slide: 0.1
    
    # first synth generates a triangle wave of 200hz with duration of 0.7 beats
    # here we are also lowing the volume a bit
    s = synth :tri, note: hz_to_midi(200), release: 0.7, amp: 0.7
    # this automation helps to simulates the hit sound, changing the fq to 50hz
    # in 0.1 beats the same time of the lpf
    control s, note: hz_to_midi(50), note_slide: 0.1
    
    # the second synth enforces the low range, adding body to the drum
    synth :tri, note: hz_to_midi(50), release: 1, amp: 0.5
  end
end


# - Snare
define :snare do
  if !snare_enable
    return
  end
  
  # This LPF is cleanning the highest range, over 2500hz, and lowering the vol.
  with_fx :lpf, cutoff: hz_to_midi(2500), amp: 0.7 do |lpf|
    # as in the kick, this automation simulates the membrane
    control lpf, cutoff: hz_to_midi(250), cutoff_slide: 1
    
    # this two synths and its autmations simulates the body of the snare drum
    # and the impact of the drumstick
    # **********
    s1 = synth :sine, note: hz_to_midi(400), release: 0.5, amp: 0.1
    control s1, note: hz_to_midi(155), note_slide: 0.05
    
    s2 = synth :sine, note: hz_to_midi(600), release: 0.5, amp: 0.1
    control s2, note: hz_to_midi(303), note_slide: 0.05
    # **********
    
    # this noise emulates the sound of the snare wire vibrating and dragging
    # over the low drumhead
    synth :noise, note: 1, release: 1, cutoff: hz_to_midi(15000), env_curve: 7, amp: 0.5
  end
end

# - Hi-hats
define :hh do |accent = false|
  if !hh_enable
    return
  end
  
  # We have two types of hits, one is accented and the other is softer
  amp = 0.5
  if accent
    amp = 2
  end
  
  # this HPF is cleanning the lower range, we only need the freqs over 15000hz
  # in this case, we are not doing any automation because we are trying to
  # model a solid instrument (two pieces of metal)
  with_fx :hpf, cutoff: hz_to_midi(15000), mix: 1 do
    # we are gonna use only a noise that will sound for short time
    synth :noise, note: 1, release: 0.3, amp: amp
  end
end


# Loop:
# -----
#
# We are grouping the notes in two bars of 4/4 (4 beats in a bar)
# and subdividing each beat in 4 subtimes == 16 subtimes per bar.
#
#     |1 + 2 + 3 + 4 +  | 1 + 2 + 3 + 4 + |
hh = ("X-x-X-x-X-x-X-x-"+"X-x-X-x-X-x-X-x-").ring()
sn = ("----o-------o---"+"----o-----o-o---").ring()
bd = ("o---o---o---o-o-"+"o---o---o---o-o-").ring()
#     |1 + 2 + 3 + 4 +  | 1 + 2 + 3 + 4 + |

# We will jump every 1/4 of beat (1/16 of a bar)
step = 1.0/4

# Reverb FX is applied to all session to generate the space feeling
with_fx :reverb, room: 0.3, damp: 0.7 do
  # This HPF cuts unwanted sub-bass freqs (lower than 50hz) that could sounds
  # bad in bigger speakers. If you are using headphones maybe yo will not
  # notice the difference.
  with_fx :hpf, cutoff: hz_to_midi(50) do
    
    # Each live_loop is a thread that plays an instument pattern,
    # we are using this pattern because playing all the instuments in a single
    # thread may cause delays that will affect in the time syncronization.
    # The main thread is the kick_loop, and the others will sync with it.
    # **********
    live_loop :kick_loop do
      if bd.tick == "o"
        kick
      end
      
      sleep step
    end
    
    live_loop :snare_loop, auto_sync: :kick_loop do
      if sn.tick() == "o"
        snare
      end
      
      sleep step
    end
    
    live_loop :hh_loop, auto_sync: :kick_loop do
      case hh.tick()
      when "x"
        hh false
      when "X"
        hh true
      end
      
      sleep step
    end
    # **********
  end
end
