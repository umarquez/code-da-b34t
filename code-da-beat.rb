use_bpm 120

with_fx :lpf, cutoff: 80 do|lpf|
  in_thread do
    loop do
      n = rrand(40, 80.0)
      control lpf, cutoff: n, slide: n/80.0
      sleep n/80.0
    end
  end
  live_loop :bg_loop do
    use_synth :saw
    play :C2
    sleep 1.0/4
    play :C2
    sleep 1.0/4
    play :C2
    sleep 0.5
  end
end

hh = ("x-x-x-x-x-x-x-x-").ring()
kk = ("o---o---o---o-o-").ring()

live_loop :kick_loop do
  if kk.tick() == "o"
    ks = synth :tri, note: hz_to_midi(250), release: 1, cutoff: 100
    control ks, note: hz_to_midi(40), slide: 0.01
  end
  
  sleep 1.0/4
end

live_loop :hh_loop do
  if hh.tick() == "x"
    with_fx :hpf, cutoff: 130, mix: 1 do
      hs = synth :noise, note: 1, release: 1.0/6
    end
  end
  
  sleep 1.0/6
end