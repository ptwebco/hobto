redis = (loadfile "redis.lua")()
function gethobtoid()
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls')
	local last = 0
    for filename in pfile:lines() do
        if filename:match('hobto%-(%d+)%.lua') and tonumber(filename:match('hobto%-(%d+)%.lua')) >= last then
			last = tonumber(filename:match('hobto%-(%d+)%.lua')) + 1
			end		
    end
    return last
end
local last = gethobtoid()
io.write("Auto Detected hobto ID : "..last)
io.write("\nEnter Full Sudo ID : ")
local sudo=io.read()
local text,ok = io.open("base.lua",'r'):read('*a'):gsub("HOBTO%-ID",last)
io.open("hobto-"..last..".lua",'w'):write(text):close()
io.open("hobto-"..last..".sh",'w'):write("while true; do\n$(dirname $0)/telegram-cli-1222 -p hobto-"..last.." -s hobto-"..last..".lua\ndone"):close()
io.popen("chmod 777 hobto-"..last..".sh")
redis:set('hobto:'..last..':fullsudo',sudo)
print("Done!\nNew Hobto Created...\nID : "..last.."\nFull Sudo : "..sudo.."\nRun : ./hobto-"..last..".sh")
