-- midi test
-- @okyeron
--
-- prints midi device info 
-- and incoming midi messages 
-- to maiden REPL


local mo = midi.connect() -- defaults to port 1 (which is set in SYSTEM > DEVICES)
local ignore_clock = true

-- process incoming midi
mo.event = function(data) 
  d = midi.to_msg(data)
  --tab.print(d)
     
  if d.type == "cc" then
      print ("cc: ".. d.cc .. " : " .. d.val)
      -- do stuff with d.cc (cc number) and d.val (incoming value)
 
    elseif d.type == "note_on" then
      print ("note-on: ".. d.note .. ", velocity:" .. d.vel)
     -- do stuff with d.note-on (note, vel, ch)
 
    elseif d.type == "note_off" then
      print ("note-off: ".. d.note .. ", velocity:" .. d.vel)
     -- do stuff with d.note-off (note, vel, ch)

    -- other types
    elseif d.type ~= "clock" and ignore_clock == true then
      print (d.type)
 
    elseif d.type == "clock" and ignore_clock == false then
      print ("clock received")
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


-- some other examples

-- helper send functions:
--mo:note_on(80,100)
--mo:note_off(80) -- optional off vel

-- raw bytes:
--mo:send{144,80,100}

-- or message table:
--mo:send{type="note_on", note=72, vel=100}
--mo:cc(72,100)

-- add a different device
--local second_midi = midi.connect(2)
--second_midi:cc(72,100)

--second_midi.event = function(data) 
--  tab.print(midi.to_msg(data))
--end
