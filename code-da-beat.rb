# ========================
# =[   Code  da  B34t   ]=
# ============ - @umarquez
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
  
  with_fx :lpf, cutoff: 110 do |lpf|
    control lpf, cutoff: 60, cutoff_slide: 0.1
    s = synth :tri, note: hz_to_midi(150.05), release: 0.7, amp: 0.7
    control s, note: hz_to_midi(50.03), note_slide: 0.25
    synth :tri, note: hz_to_midi(50.07), release: 1, amp: 0.5
  end
end


# - Snare
define :snare do
  if !snare_enable
    return
  end
  
  with_fx :lpf, cutoff: 100, amp: 0.7 do |lpf|
    control lpf, cutoff: 60, cutoff_slide: 2
    s1 = synth :beep, note: hz_to_midi(400.1), release: 0.5, amp: 0.1
    control s1, note: hz_to_midi(155), note_slide: 0.1
    s2 = synth :beep, note: hz_to_midi(600.3), release: 0.5, amp: 0.1
    control s2, note: hz_to_midi(303), note_slide: 0.05
    synth :noise, note: 1, release: 0.75, cutoff: 130, env_curve: 7, amp: 0.5
  end
end

# - High Hats
define :hh do |accent = false|
  if !hh_enable
    return
  end
  
  amp = 0.5
  if accent
    amp = 2
  end
  
  with_fx :hpf, cutoff: 130, mix: 1 do
    synth :noise, note: 100, release: 0.3, amp: amp
  end
end


# Loop:
# -----
#     |1 + 2 + 3 + 4 +  | 1 + 2 + 3 + 4 + |
hh = ("X-x-X-x-X-x-X-x-"+"X-x-X-x-X-x-X-x-").ring()
sn = ("----o-------o---"+"----o-----o-o---").ring()
bd = ("o---o---o---o-o-"+"o---o---o---o-o-").ring()
#     |1 + 2 + 3 + 4 +  | 1 + 2 + 3 + 4 + |

step = 1.0/4

# Reverb FX is applied to all session to generate the space feeling
with_fx :reverb, room: 0.3, damp: 0.7 do
  # This HPF cuts unwanted sub-bass freqs.
  with_fx :hpf, cutoff: hz_to_midi(50) do
    
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
  end
end
