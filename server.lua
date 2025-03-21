RegisterServerEvent("fiveshield:banPlayer", function()
   local src = source 
   DropPlayer(src, "kick")
end)