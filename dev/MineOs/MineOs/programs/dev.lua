term.clear()
term.setCursorPos(1,1)
print("Enter Code to access Dev Tools")
local input = read()
if input == "dev123" then
    while true do
        term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.white)
        print("Dev Tools 1.0")
        local command = read()
        if command == "Update" then
            shell.run("copy","MineOs","disk/MineOs/MineOs")
            shell.run("copy","startup.lua","disk/MineOs/startup.lua")
        elseif command == "Burn" then
            print("This process will delete everything you have on your floppy do you wish to continue? Type Y/N")
            if not string.lower(read()) == "y" then else
                shell.run("delete /disk/*")
                if fs.exists("/disk/startup.lua") then
                    printError("disk/startup already exists")
                else
                    term.setTextColor(colors.white)
                    term.write("Installing disk startup from cloud")
                    shell.run("pastebin get Jv7sRxLW /disk/startup.lua")
                    term.setTextColor(colors.lime)
                    print(" Success")
                end
                if fs.exists("/disk/MineOs/startup.lua") then
                    printError("disk/MineOs/startup already exists")
                else
                    term.setTextColor(colors.white)
                    term.write("Copying MineOs/startup")
                    shell.run("copy","/startup.lua","/disk/MineOs/startup.lua")
                    term.setTextColor(colors.lime)
                    print(" Success")
                end
                if fs.exists("disk/MineOs/MineOs") then
                    printError("/disk/MineOs/Bios already exists")
                else
                    term.setTextColor(colors.white)
                    term.write("Copying MineOs")
                    shell.run("copy","/MineOs","/disk/MineOs/MineOS")
                    term.setTextColor(colors.lime)
                    print(" Success")
                end
                sleep(3)
            end
        elseif command == "exit" then
            term.clear()
            term.setCursorPos(1,1)
            break
        end
    end
else
    printError("Wrong Password")
end