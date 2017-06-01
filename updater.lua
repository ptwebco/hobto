local pfile = io.popen('ls')
for filename in pfile:lines() do
  if filename:match('hobto%-(%d+)%.lua') then
    local text, ok = io.open(filename,'r'):read('*a'):gsub([[localfile("hobto.lua")()]],[[hobto = dofile("hobto.lua")]]):gsub([[update(data, hobto_id)]],[[hobto.update(data, hobto_id)]])
    io.open(filename,'w'):write(text):close()
  end
end
print("Bots Source Updated!")
