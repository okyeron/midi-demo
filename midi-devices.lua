-- midi test
-- @okyeron
--
-- prints midi device info 
-- and incoming midi messages 
-- to maiden REPL


local mo = midi.connect(1) -- defaults to port 1 (which is set in SYSTEM > DEVICES)

-- process incoming midi
mo.event = function(data) 
  d = midi.to_msg(data)
    tab.print(d)
    if d.type == "cc" then
        print ("cc: ".. d.cc .. " " .. d.val)
        --print (d.val)
     -- do stuff with d.cc (cc number) and d.val (incoming value)
    end

    if d.type == "note_on" then
     -- do stuff with d.note-on (note, vel, ch)
      print ("note-on: ".. d.note .. " " .. d.vel)
    end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function showme()
    print("-midi.list-")
    --tab.print(midi.vports)

    --table.insert(midi.devices.options.midi,1)
    print("-midi.devices-")
    tab.print(midi.devices)
    print("-")
    for w,z in pairs(midi.devices) do
        tab.print(z)

        print("-")
    end
    
    print("-")
    print("-midi vports-")
    tab.print(midi.vports)
    for x,y in pairs(midi.vports) do
        print (x .. ": " .. y.name)
    end
    print("-")
    print("-midi device details-")
    for i,v in pairs(midi.devices) do
      tab.print(midi.devices[i])
      print("-")
    end
        
end 

function init()
    showme()
end

--print(midi.devices[3].name)


-- helper send functions:
--o.note_on(80,100)
--o.note_off(80) -- optional off vel

-- raw bytes:
--o.send{144,80,100}

-- or message table:
--o.send{type="note_on", note=72, vel=100}
--o.cc(72,100)

-- select different port
--local second_midi = midi.connect(2)
--second_midi.cc(72,100)

--second_midi.event = function(data) 
--  tab.print(midi.to_msg(data))
--end
