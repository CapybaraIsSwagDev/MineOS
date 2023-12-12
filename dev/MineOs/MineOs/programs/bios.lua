local Yoffset = 1
local cursorY = 1+Yoffset
function Clear()
    term.clear()
    term.setCursorPos(1,1)
end
function Bg()
    term.setCursorPos(1,1)
    term.setBackgroundColor(colors.gray)
    term.clearLine()
    term.write("Mine Os Bios")
    term.setBackgroundColor(colors.black)
end
function BootToShell()
    shell.run("shell")
end
function Dboot(table)
    shell.run("/"..table[1].."/"..table[2])
end
function FindBoot()
    -- a is array that will be send to output
    local a = {}
    --Find all BootInfo files in computer 
    local BootinfoFolders = fs.find("/*/.BootInfo")
    --go thru all of them an get the bootable ones
    for i=1,#BootinfoFolders do
        settings.load("/"..BootinfoFolders[i])
        --Check if bootable is yes cotinuo if not do nothing
        if not settings.get("bootable") then
        else
            --if bootable add to array 'a'
            --table {dir,bootfile name}
            local b = {
                name = fs.getDir(BootinfoFolders[i]),
                func = {fs.getDir(BootinfoFolders[i]),settings.get("bootdir")}
            }
            table.insert(a,b)
        end
    end
    output = a
    if output[1] == nil then
        output = {{name = "None",func = "None"}}
    end
    return output
end
function pAll(list,status)
    Clear()
    Bg()
    term.setCursorPos(1,cursorY)
    term.write(">")
    if status then
        for i=1,#list,1 do
            local A = string.format("%q",list[i].State)
            if A == "nil" then
                A = ""
            end
            term.setCursorPos(3,i+Yoffset)
            term.write(list[i].name) 
            if A == "true" then
                term.setTextColor(colors.lime)
            elseif A == "false" then
                term.setTextColor(colors.red)
            end
            print(" "..A)
            term.setTextColor(colors.white)
        end
    else
        for i=1,#list,1 do
            term.setCursorPos(3,i+Yoffset)
            print(list[i].name)
        end
    end
end
function main(list,custom)
    if custom == true then
        local loop = true
        cursorY = 1+Yoffset
        while loop do
            pAll(list)
            local event, key, is_held = os.pullEvent("key")
            if key == 264 then
                if #list+Yoffset > cursorY then
                    cursorY = cursorY + 1
                end
            elseif key == 265 then
                if 1+Yoffset < cursorY then
                    cursorY = cursorY - 1
                end
            elseif key == 257 then
                local a = cursorY-Yoffset
                loop = false
                return list[a].func
            end
        end
    elseif custom == false then
        local loop = true
        cursorY = 1+Yoffset
        settings.clear()
        settings.load("/MineOs/Boot.dat")
        local data = settings.get("Data")
        while loop do
            pAll(data,true)
            local event, key, is_held = os.pullEvent("key")
            if key == 264 then
                if #data+Yoffset > cursorY then
                    cursorY = cursorY + 1
                end
            elseif key == 265 then
                if 1+Yoffset < cursorY then
                    cursorY = cursorY - 1
                end
            elseif key == 257 then
                local a = cursorY-Yoffset
                if data[a].func == "return" then
                    loop = false
                    settings.set("Data",data)
                    settings.save("/MineOs/Boot.dat")
                    settings.clear()
                elseif data[a].func == "CustomOs" then
                    if data[a].State then
                        data[a].State = false
                    else
                        term.clear()
                        term.setCursorPos(1,1)
                        print("Do you wanna allow third-party software to be automaticly run on this machine this will also delete some MineOs Files(MineOs Shell Will be disabled) Y/N\n\nThis will take action after reboot.")
                        local input = read()
                        input = string.lower(input)
                        if input == "y" then
                            data[a].State = true
                        end
                    end
                else
                    if data[a].State then
                        data[a].State = false
                    else
                        data[a].State = true
                    end
                end
            end
        end
    else
        local loop = true
        cursorY = 1+Yoffset
        while loop do
            pAll(list)
            local event, key, is_held = os.pullEvent("key")
            if key == 264 then
                if #list+Yoffset > cursorY then
                    cursorY = cursorY + 1
                end
            elseif key == 265 then
                if 1+Yoffset < cursorY then
                    cursorY = cursorY - 1
                end
            elseif key == 257 then
                local a = cursorY-Yoffset
                list[a].func()
                loop = false
            end
        end
    end
end
local menulist = {
    {
        name = "Bootable Drives",
        func = function ()
            local sublist = FindBoot()
            local selected = main(sublist,true)
            if not selected.name == "None" then
                settings.clear()
                settings.load("/MineOs/Boot.dat")
                settings.set("Boot","/"..selected.name.."/"..selected.func)
                settings.save("/MineOs/Boot.dat")
                settings.clear() 
            else    
                settings.clear()
                settings.load("/MineOs/Boot.dat")
                settings.set("Boot","")
                settings.save("/MineOs/Boot.dat")
                settings.clear()           
            end
        end
    },
    {
        name = "Edit Settings",
        func = function ()
            settings.clear()
            settings.load("/MineOs/Boot.dat")
            local list = settings.get("Data")
            settings.clear()
            local out = main(list,false)
        end
    },
    {
        name = "Reboot",
        func = os.reboot
    },
}
while true do
    main(menulist)
end