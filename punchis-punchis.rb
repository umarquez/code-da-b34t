# ======================
#  Punchis-punchis v0.1
#           - @umarquez
# ======================
use_bpm 120


# Instruments:
# ------------
#
# - High-hats
# - Snare
# - Bass Drum (kick)

define :kick do
  with_fx :lpf, cutoff: 110 do |lpf|
    control lpf, cutoff: 40, cutoff_slide: 0.1
    s = synth :tri, note: hz_to_midi(150.01), release: 1.1
    synth :beep, note: hz_to_midi(50.1), release: 0.75
    control s, note: hz_to_midi(20), note_slide: 0.1
  end
end


define :snare do
  with_fx :lpf, cutoff: 100, amp: 0.7 do
    synth :beep, note: hz_to_midi(300), release: 0.1, amp: 0.15
    synth :beep, note: hz_to_midi(600), release: 0.1, amp: 0.15
    synth :noise, note: 1, release: 0.5, cutoff: 100, env_curve: 7
  end
end


define :hh do |accent = false|
  amp = 0.5
  if accent
    amp = 2
  end
  with_fx :hpf, cutoff: 130, mix: 1 do
    synth :noise, note: 100, release: 0.3, amp: amp
  end
end


# Drumset loop:
# -------------
#
# HH||  X-x-X-x-X-x-X-x-|X-x-X-x-X-x-X-x-  ||
#  S||: ----o-------o---|----o-------o--- :||
# BD||  o---o---o---o-o-|o---o---o---o-o-  ||
#       1 + 2 + 3 + 4 +  1 + 2 + 3 + 4 +

with_fx :reverb, room: 0.3, damp: 0.7 do
  live_loop :kick_loop do
    3.times do
      kick
      sleep 1
    end
    
    kick
    sleep 0.5
    kick
    sleep 0.5
  end
  
  
  live_loop :snare_loop, auto_sync: :kick_loop do
    3.times do
      sleep 1
      snare
      sleep 1
    end
    
    sleep 2.0/4
    snare
    sleep 2.0/4
    snare
    sleep 1
  end
  
  live_loop :hh_loop, auto_sync: :kick_loop do
    hh
    sleep 0.5
    hh true
    sleep 0.5
  end
end
