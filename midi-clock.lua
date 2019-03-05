-- midi clock examples
-- works well with drum machine like tr-09
--
-- enc 2 = bpm
-- enc 3 send clock on/off
-- key 2 = start
-- key 3 = stop

-- author: steven noreyko
--
--


m = midi.connect(1)
local klk
local ticks_per_step = 6
local steps_per_beat = 4

local sendclock = true
local bpm = 100

m.event = function(data)
  local d = midi.to_msg(data)
  -- print something for various data types
  -- ignore clock for the moment but look at other types
  if d.type ~= "clock" then
    if d.type == "cc" then
        print("ch:".. d.ch .. " " .. d.type .. ":".. d.cc.. " ".. d.val)
    elseif d.type=="note_on" or d.type=="note_off" then
        --print("ch:".. d.ch .. " " .. d.type .. " note:".. d.note .. " vel:" .. d.vel)
    elseif d.type=="channel_pressure" or d.type=="pitchbend" then
        print("ch:".. d.ch .. " " .. d.type .. " val:" .. d.val)
        
    elseif d.type=="start" then
        print("start")
    elseif d.type=="stop" then
        print("stop")
    elseif d.type=="continue" then
        print("continue")
    else
        tab.print(d)
    end
  end

end

function init()
    klk = metro.init()  
    klk.callback = tst
    klk.time = 60/(ticks_per_step * steps_per_beat * bpm)
    klk:start()

    redraw()
end

function tst()
    if (sendclock) then
        m.clock()
    end
end

function key(n, z)
    if n == 2 and z == 1 then -- start
        m.start()
        print ("start")
    end 
    if n == 3 and z == 1 then -- 
        m.stop()
        print ("stop")
        -- song select test
        --sng = math.random(0,3)
        --print ("song select: " ..sng)
        --m.song_select(sng)
    end 
end 

function enc(n,d)
  if n == 2 then
    bpm_change(bpm + d)
    bpm = bpm + d
  end
  if n == 3 then
    if (d > 0) then
        sendclock = true
    else
        sendclock = false
    end
  end
  redraw()
end

function bpm_change(bpm)
  klk.time = 60/(ticks_per_step * steps_per_beat * bpm)
end

-- screen redraw function
function redraw()
  -- clear screen
  screen.clear()
  -- set pixel brightness (0-15)
  screen.level(15)
  screen.line_width(1)
  screen.font_face(0)
  screen.font_size(8)

  screen.move(0,10)
  screen.text("MIDI CLOCK TEST")
  
  screen.move(0,20)
  if (sendclock) then
    screen.text("Clock on")
  else
    screen.text("Clock off")
  end
  screen.move(0,30)
  screen.text("BPM: ".. bpm)

  screen.update()
end