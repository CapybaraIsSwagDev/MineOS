-- SPDX-FileCopyrightText: 2017 Daniel Ratcliffe
--
-- SPDX-License-Identifier: LicenseRef-CCPL

local tArgs = { ... }
if #tArgs < 1 then
    print("Usage: cd <path>")
    return
end

local sNewDir = shell.resolve(tArgs[1])
if fs.isDir(sNewDir) then
    if shell.isBlocked(sNewDir) then 
        shell.setDir(sNewDir)
    end
else
    print("Not a directory")
    return
end
