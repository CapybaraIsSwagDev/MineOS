function load(libname)
    local file,e = loadfile("/lib/"..libname..".lib")
    if file == nil then error("Cannot Load Lib: '"..libname.."'Error: "..e,5) else
    local lib = file()
    return lib end
end
function DownloadLib(libfile)
    local file = fs.open("hello.txt", "w")
    local libfile = fs.open(libfile, "w")
    file.write("local lib = {}\n")
    shell.run("pastebin")
    file.write("return lib")
    file.close()
end
